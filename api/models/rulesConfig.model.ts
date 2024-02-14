import { CharacterRulesConfig } from "./characterRulesConfig.model";

export class RulesConfig {
    characterRules: CharacterRulesConfig = new CharacterRulesConfig();
    skillProgressionBonuses: number[] = [];
}