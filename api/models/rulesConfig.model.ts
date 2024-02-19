import { CharacterRulesConfig } from "./characterRulesConfig.model";
import { ItemRulesConfig } from "./itemRulesConfig.model";

export class RulesConfig {
    characterRules: CharacterRulesConfig = new CharacterRulesConfig();
    itemRules: ItemRulesConfig = new ItemRulesConfig();
    skillProgressionBonuses: number[] = [];
}