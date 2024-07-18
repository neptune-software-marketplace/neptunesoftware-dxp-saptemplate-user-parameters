var selectedItem = oEvent.getParameter("selectedItem");
var context = selectedItem.getBindingContext();

var rec = {};
rec.PARID = context.getProperty("PARAMID");
rec.PARTXT = context.getProperty("PARTEXT");
ModelData.Add(tabParam,rec);
