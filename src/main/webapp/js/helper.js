
/**
 * Number Add Comma
 * 숫자 콤마 추가
 */
Handlebars.registerHelper("addComma", function (value) {
    var regExp = /\B(?=(\d{3})+(?!\d))/g

    return value.toString().replace(regExp, ",");
})


/**
 * Number Remove Comma
 * 숫자 콤마 제거
 */
Handlebars.registerHelper("removeComma", function (value) {
    var regExp = /,/gi;

    return value.toString().replace(regExp, "");
})


/**
 * Number Convert To Date
 * 숫자를 날짜로 변환
 *
 *  # Format
 *   ex.) YYYY-MM-DD HH:mm:ss:SSS
 *
 */
Handlebars.registerHelper("convertToDate", function (date, format) {
    if(isEmpty(date)){
        //ToDo 날짜 Default 설정 필요
        return "-";
    }
    if(isEmpty(format)){
        format = "YYYY.MM.DD";
    }
    return moment(date).format(format);
})


/**
 * Date 구분자 제거
 *
 */
Handlebars.registerHelper("dateToNumber", function (value) {
    var regExp = /\d/gi;

    return value.toString().replace(regExp, "");
})


/**
 * if
 *
 * ex.)
 * {{#dalbit_if value1 "==" "test1"}}
 *      true code      {{! value1 == "test1" }}
 * {{else}}
 *      false code      {{! value1 != "test1" }}
 * {{/dalbit_if}}
 *
 */
Handlebars.registerHelper("dalbit_if", function(v1, operator, v2, options){
    switch (operator) {
        case '==':
            return (v1 == v2) ? options.fn(this) : options.inverse(this);
        case '===':
            return (v1 === v2) ? options.fn(this) : options.inverse(this);
        case '!=':
            return (v1 != v2) ? options.fn(this) : options.inverse(this);
        case '!==':
            return (v1 !== v2) ? options.fn(this) : options.inverse(this);
        case '<':
            return (v1 < v2) ? options.fn(this) : options.inverse(this);
        case '<=':
            return (v1 <= v2) ? options.fn(this) : options.inverse(this);
        case '>':
            return (v1 > v2) ? options.fn(this) : options.inverse(this);
        case '>=':
            return (v1 >= v2) ? options.fn(this) : options.inverse(this);
        default:
            return options.inverse(this);
    }
})

Handlebars.registerHelper("index", function(value, options)
{
    return parseInt(value) + 1;
});