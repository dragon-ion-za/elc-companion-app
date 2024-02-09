const fs = require("fs");

export const readFile = (filePath: string) : any => {
    let rawJson = fs.readFileSync(filePath, 'utf8');
    return JSON.parse(rawJson);
};