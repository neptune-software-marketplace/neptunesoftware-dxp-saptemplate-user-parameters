var binding = oEvent.getParameter("itemsBinding");
var value = oEvent.getParameter("value");
var filter = new sap.ui.model.Filter("FILTER", "Contains", value);
binding.filter([filter]);
