/** @type {import("prettier").Config} */
export default {
    trailingComma: "none", // не ставим запятые после последнего символа в объектах или массивах
    tabWidth: 4, 
    useTabs: true,
    semi: false, // не ставить ; в конце строк
    singleQuote: true, // использовать одинарные ковычки
    jsxSingleQuote: true, // в jsx тоже использовать одинарные ковычки
    arrowParens: "avoid", // не добавлять скобки вокруг единственного элемента стрелочной функции
    importOrderSeparation: true,
    importOrderSortSpecifiers: true,
    importOrderCaseInsensitive: true,
    importOrderParserPlugins: [
        "classProperties",
        "decorators-legacy",
        "typescript"
    ],
    importOrder: ["<THIRD_PARTY_MODULES>", "^@/(.*)$", "^../(.*)", "^./(.*)"],
    plugins: ["@trivago/prettier-plugin-sort-imports"]
}