import config from "config";
import { readFile } from "../services/read-file.service";
import { RulesConfig } from "../models/rulesConfig.model";
import { EquipableModel } from "../models/equipable.model";
import { LookupDataServiceSingleton } from "../services/lookupData.service";
import { SkillModel } from "../models/skill.model";

class CharacterRulesEngine {
    private rulesCache: RulesConfig | undefined = undefined;

    public calculateHitpoints(equipment: EquipableModel[]) : number {
        if (this.rulesCache === undefined) this.initRulesCache();

        var hp = this.rulesCache!.characterRules.baseHp;

        equipment.filter((x) => x.slotId === 'chest' && x.containerId === 'root')
        .forEach((x) => {
            var item = LookupDataServiceSingleton.getItems().filter((y) => y.id == x.id)[0];

            if (item !== undefined) {
                var armour = item.attributes.filter((y) => y.type === 'armour')[0];

                if (armour !== undefined) {
                    hp += armour.value;
                }
            }
        });

        return hp;
    }

    public calculateMitigationScore(equipment: EquipableModel[], skills: SkillModel[]) : number {
        if (this.rulesCache === undefined) this.initRulesCache();

        var mitigation = this.rulesCache!.characterRules.baseMitigation;

        equipment.filter((x) => x.slotId === 'chest' && x.containerId === 'root')
        .forEach((x) => {
            var item = LookupDataServiceSingleton.getItems().filter((y) => y.id == x.id)[0];

            if (item !== undefined) {
                var mitigationBonus = item.attributes.filter((y) => y.type === 'mitigation')[0];

                if (mitigationBonus !== undefined) {
                    mitigation += mitigationBonus.value;
                }
            }
        });

        mitigation += this.rulesCache!.skillProgressionBonuses[Math.floor(skills.filter((x) => x.id === 'skl_combatsurvival')[0].progression / 8)] ?? 0;

        return mitigation;
    }

    private initRulesCache() {
        let json = readFile(`${config.get("dataFileRoot")}rulesConfig.json`);
        this.rulesCache = json as RulesConfig;
    }
}

export const CharacterRulesEngineSingleton = new CharacterRulesEngine();