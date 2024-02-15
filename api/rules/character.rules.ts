import config from "config";
import { readFile } from "../services/read-file.service";
import { RulesConfig } from "../models/rulesConfig.model";
import { EquipableModel } from "../models/equipable.model";
import { LookupDataServiceSingleton } from "../services/lookupData.service";
import { SkillModel } from "../models/skill.model";
import { ActionViewModel } from "../view-models/action.viewmodel";

class CharacterRulesEngine {
    private rulesCache: RulesConfig | undefined = undefined;

    public calculateHitpoints(equipment: EquipableModel[]) : number {
        if (this.rulesCache === undefined) this.initRulesCache();

        var hp = this.rulesCache!.characterRules.baseHp;

        equipment.filter((x) => x.slotId === 'chest' && x.containerId === 'root')
        .forEach((x) => {
            var item = LookupDataServiceSingleton.getItems().filter((y) => y.id == x.itemId)[0];

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
            var item = LookupDataServiceSingleton.getItems().filter((y) => y.id == x.itemId)[0];

            if (item !== undefined) {
                var mitigationBonus = item.attributes.filter((y) => y.type === 'mitigation')[0];

                if (mitigationBonus !== undefined) {
                    mitigation += mitigationBonus.value;
                }
            }
        });

        mitigation += this.rulesCache!.skillProgressionBonuses[Math.floor(skills.find((x) => x.id === 'skl_combatsurvival')?.progression ?? 0 / 8)] ?? 0;

        return mitigation;
    }

    public calculateAccuracy(skills: SkillModel[]) : number {
        if (this.rulesCache === undefined) this.initRulesCache();

        let accuracy = 0;

        accuracy += this.rulesCache!.skillProgressionBonuses[Math.floor(skills.find((x) => x.id === 'skl_weaponstraining')?.progression ?? 0 / 8)] ?? 0;

        return accuracy;
    }

    public calculateActions(equipment: EquipableModel[], skills: SkillModel[], accuracyBonus: number) : ActionViewModel[] {
        if (this.rulesCache === undefined) this.initRulesCache();

        let actions: ActionViewModel[] = [];

        let equipmentIds = equipment.map(x => x.itemId);
        var items = LookupDataServiceSingleton.getItems();
        let actionItems = items.filter(x => equipmentIds.includes(x.id) && x.attributes.find(y => y.type === 'onAction') !== undefined);

        actionItems.forEach(x => {
            x.attributes.filter(y => y.type === 'onAction').forEach(y => {
                let effect = LookupDataServiceSingleton.getEffects().find(z => z.id === y.effectId);

                if (effect !== undefined) {
                    let action = new ActionViewModel();

                    action.name = `${effect.title}${x.name}`;
                    action.blurb = effect.blurb;
                    action.description = effect.description;
                    action.damage = this.rulesCache!.itemRules.baseDamage;
                    action.cost = this.rulesCache!.itemRules.baseActionCost;
                    action.accuracy = accuracyBonus;
    
                    actions.push(action);
                } else {
                    console.error(`Effect with ID ${y.effectId} is undefined!`);
                }
            });
        });

        let abilityIds = skills.flatMap(x => x.abilityIds);
        var abilities = LookupDataServiceSingleton.getAbilities();
        let actionAbilities = abilities.filter(x => abilityIds.includes(x.id) && x.attributes.find(y => y.type === 'onAction') !== undefined);

        actionAbilities.forEach(x => {
            x.attributes.filter(y => y.type === 'onAction').forEach(y => {
                let effect = LookupDataServiceSingleton.getEffects().find(z => z.id === y.effectId);
                let cost = x.attributes.find(z => z.type === 'costActions');

                if (effect !== undefined) {
                    let action = new ActionViewModel();

                    action.name = `${x.name}`;
                    action.blurb = effect.blurb;
                    action.description = effect.description;
                    action.cost = cost?.value ?? this.rulesCache!.itemRules.baseActionCost;
    
                    actions.push(action);
                } else {
                    console.error(`Effect with ID ${y.effectId} is undefined!`);
                }
            });
        });

        return actions;
    }

    private initRulesCache() {
        let json = readFile(`${config.get("dataFileRoot")}rulesConfig.json`);
        this.rulesCache = json as RulesConfig;
    }
}

export const CharacterRulesEngineSingleton = new CharacterRulesEngine();