import config from "config";
import { readFile } from "../services/read-file.service";
import { RulesConfig } from "../models/rulesConfig.model";
import { EquipableModel } from "../models/equipable.model";
import { LookupDataServiceSingleton } from "../services/lookupData.service";
import { SkillModel } from "../models/skill.model";
import { ItemConstants } from "../constants/item.constants";
import { AttributeTypes } from "../constants/attributeTypes.enum";

class CharacterRulesEngine {
    private rulesCache: RulesConfig | undefined = undefined;

    public calculateHitpoints(equipment: EquipableModel[], talentIds: string[]) : number {
        if (this.rulesCache === undefined) this.initRulesCache();

        var hp = this.rulesCache!.characterRules.baseHp;
        hp += this.calculateValueFromEquipment(equipment, ItemConstants.SLOT_CHEST, ItemConstants.STAT_HITPOINT);
        hp += this.calculateValueFromTalentsFlaws(talentIds, ItemConstants.STAT_HITPOINT);

        return hp;
    }

    public calculateMitigationScore(equipment: EquipableModel[], talentIds: string[], skills: SkillModel[]) : number {
        if (this.rulesCache === undefined) this.initRulesCache();

        var mitigation = this.rulesCache!.characterRules.baseMitigation;
        mitigation += this.calculateValueFromEquipment(equipment, ItemConstants.SLOT_CHEST, ItemConstants.STAT_MITIGATION);
        mitigation += this.calculateValueFromTalentsFlaws(talentIds, ItemConstants.STAT_MITIGATION);
        mitigation += this.calculateValueFromSkills(skills, ItemConstants.SKILL_COMBATSURVIVAL);

        return mitigation;
    }

    public calculateWeaponAccuracy(weapon: EquipableModel, talentIds: string[], skills: SkillModel[]) : number {
        if (this.rulesCache === undefined) this.initRulesCache();

        let accuracy = 0;
        accuracy += this.calculateValueFromWeaponMods(weapon, ItemConstants.TEST_ACCURACY);
        accuracy += this.calculateValueFromTalentsFlaws(talentIds, ItemConstants.TEST_ACCURACY);
        accuracy += this.calculateValueFromSkills(skills, ItemConstants.SKILL_WEAPONSTRAINING);

        return accuracy;
    }

    private initRulesCache() {
        let json = readFile(`${config.get("dataFileRoot")}rulesConfig.json`);
        this.rulesCache = json as RulesConfig;
    }

    private calculateValueFromWeaponMods(weapon: EquipableModel, targetId: string) : number {
        let value: number = 0;

        var item = LookupDataServiceSingleton.getItems().filter((y) => y.id == weapon.itemId)[0];

        if (item !== undefined) {
            var bonuses = item.attributes.filter((y) => y.type === AttributeTypes.Bonus && y.targetId === targetId);

            bonuses.forEach((bonus) => {
                value += parseInt(bonus.value);
            });
        }

        return value;
    }

    private calculateValueFromEquipment(equipment: EquipableModel[], slotId: string, targetId: string) : number {
        let value: number = 0;

        equipment.filter((x) => x.slotId === slotId)
        .forEach((x) => {
            var item = LookupDataServiceSingleton.getItems().filter((y) => y.id == x.itemId)[0];

            if (item !== undefined) {
                var bonuses = item.attributes.filter((y) => y.type === AttributeTypes.Bonus && y.targetId === targetId);

                bonuses.forEach((bonus) => {
                    value += parseInt(bonus.value);
                });
            }
        });

        return value;
    }

    private calculateValueFromTalentsFlaws(talentIds: string[], targetId: string) : number {
        let value: number = 0;

        talentIds.forEach((x) => {
            var talent = LookupDataServiceSingleton.getTalentsFlaws().filter((y) => y.id == x)[0];

            if (talent !== undefined) {
                var bonuses = talent.attributes.filter((y) => y.type === AttributeTypes.Bonus && y.targetId === targetId);

                bonuses.forEach((bonus) => {
                    value += parseInt(bonus.value);
                });
            }
        });

        return value;
    }

    private calculateValueFromSkills(skills: SkillModel[], skillId: string) : number {
        return this.rulesCache!.skillProgressionBonuses[Math.floor(skills.find((x) => x.id === skillId)?.progression ?? 0 / 8)] ?? 0;
    }
}

export const CharacterRulesEngineSingleton = new CharacterRulesEngine();