ace.define("ace/theme/slate",["require","exports","module","ace/lib/dom"], function(require, exports, module) {

exports.isDark = true;
exports.cssClass = "ace-slate";
exports.cssText = "";

var dom = require("../lib/dom");
dom.importCssString(exports.cssText, exports.cssClass);

});
