class zcl_nad_core_user_parameter definition
  public
  final
  create public .

public section.

  interfaces /neptune/if_nad_server .

  types:
    begin of ty_t001w,
          werks    type t001w-werks,
          name1    type t001w-name1,
          filter   type string,
    end of ty_t001w .
  types:
    begin of ty_t024e,
          ekorg    type t024e-ekorg,
          ekotx    type t024e-ekotx,
          filter   type string,
    end of ty_t024e .
  types:
    begin of ty_t024,
          ekgrp    type t024-ekgrp,
          eknam    type t024-eknam,
          filter   type string,
    end of ty_t024 .
  types:
    begin of ty_tvkot,
          vkorg    type tvkot-vkorg,
          vtext    type tvkot-vtext,
          filter   type string,
    end of ty_tvkot .
  types:
    begin of ty_tvtwt,
          vkorg    type tvkot-vkorg,
          vtweg    type tvtwt-vtweg,
          vtext    type tvtwt-vtext,
          filter   type string,
    end of ty_tvtwt .
  types:
    begin of ty_tspat,
          spart    type tspat-spart,
          vtext    type tspat-vtext,
          filter   type string,
    end of ty_tspat .
  types: begin of ty_screen_param,
          werks     type string,
          werks_txt type string,
          ekorg     type string,
          ekorg_txt type string,
    end of ty_screen_param.


  data it_t001w type standard table of ty_t001w .
  data it_t024e type standard table of ty_t024e .
  data it_t024  type standard table of ty_t024 .
  data it_tspat type standard table of ty_tspat .
  data it_tvkot type standard table of ty_tvkot .
  data it_tvtwt type standard table of ty_tvtwt .
  data it_tparat type standard table of tparat.
  data it_filter type standard table of tparat.
  data it_parameters type standard table of bapiparam.
  data wa_filter type tparat.
  data wa_parameters type bapiparam.
  data wa_screen_param type ty_screen_param.
protected section.
private section.

  methods SAVE .
  methods SET_FILTER .
  methods GET_DATA .
  methods GET_LIST_TPARAT .
  methods GET_LIST_T001W .
  methods GET_LIST_T024E .
  methods GET_LIST_T024 .
  methods GET_LIST_TVKOT .
  methods GET_LIST_TVTWT .
  methods GET_LIST_TSPAT .
ENDCLASS.



CLASS ZCL_NAD_CORE_USER_PARAMETER IMPLEMENTATION.


method /neptune/if_nad_server~handle_on_ajax.


  case ajax_id.

    when 'GET_DATA'.
      call method get_data( ).

    when 'SAVE'.
      call method save( ).

    " Parameters
    when 'GET_LIST_TPARAT'.
      call method get_list_tparat( ).

    " Plant
    when 'GET_LIST_T001W'.
      call method get_list_t001w( ).

    " Purchase Organization
    when 'GET_LIST_T024E'.
      call method get_list_t024e( ).

    " Purchase Group
    when 'GET_LIST_T024'.
      call method get_list_t024( ).

    " Sales Organization
    when 'GET_LIST_TVKOT'.
      call method get_list_tvkot( ).

    " Distribution Channel
    when 'GET_LIST_TVTWT'.
      call method get_list_tvtwt( ).

    " Division
    when 'GET_LIST_TSPAT'.
      call method get_list_tspat( ).

  endcase.


endmethod.


method get_data.

data: it_return type standard table of bapiret2,
      lv_tabix  type sy-tabix.


* Get Data
  call function 'BAPI_USER_GET_DETAIL'
    exporting
      username             = sy-uname
      cache_results        = space
    tables
      parameter            = it_parameters
      return               = it_return.

* Get Filter
  call method set_filter( ).

* Build Data
  loop at it_parameters into wa_parameters.

    lv_tabix = sy-tabix.

    read table it_filter into wa_filter with key paramid = wa_parameters-parid.

    if sy-subrc ne 0.
       delete it_parameters index lv_tabix.
       continue.
    endif.

    case wa_parameters-parid.

      when 'WRK'.
        wa_screen_param-werks = wa_parameters-parva.

      when 'EKO'.
        wa_screen_param-ekorg = wa_parameters-parva.

    endcase.

  endloop.


endmethod.


method get_list_t001w.

data: wa_t001w type ty_t001w,
      lv_tabix type sy-tabix.


* Get T001W
  select werks name1
         from t001w
         into corresponding fields of table it_t001w.

* Build Filter
  loop at it_t001w into wa_t001w.

    lv_tabix = sy-tabix.

    concatenate wa_t001w-werks
                wa_t001w-name1
                into wa_t001w-filter.

    modify it_t001w from wa_t001w index lv_tabix.

  endloop.

* Sorting
  sort it_t001w by werks.


endmethod.


method get_list_t024.

data: wa_t024 type ty_t024,
      lv_tabix type sy-tabix.


* Get t024
  select ekgrp eknam
         from t024
         into corresponding fields of table it_t024.

* Build Filter
  loop at it_t024 into wa_t024.

    lv_tabix = sy-tabix.

    concatenate wa_t024-ekgrp
                wa_t024-eknam
                into wa_t024-filter.

    modify it_t024 from wa_t024 index lv_tabix.

  endloop.

* Sorting
  sort it_t024 by ekgrp.


endmethod.


method get_list_t024e.

data: wa_t024e type ty_t024e,
      lv_tabix type sy-tabix.


* Get t024e
  select ekorg ekotx
         from t024e
         into corresponding fields of table it_t024e.

* Build Filter
  loop at it_t024e into wa_t024e.

    lv_tabix = sy-tabix.

    concatenate wa_t024e-ekorg
                wa_t024e-ekotx
                into wa_t024e-filter.

    modify it_t024e from wa_t024e index lv_tabix.

  endloop.

* Sorting
  sort it_t024e by ekorg.


endmethod.


method get_list_tparat.


* Get Filter
  call method set_filter( ).

* Get Paremeters
  select *
         from tparat
         into table it_tparat
         for all entries in it_filter
         where paramid eq it_filter-paramid
           and sprache eq sy-langu.

* Sorting
  sort it_tparat by partext.


endmethod.


method get_list_tspat.

data: wa_tspat type ty_tspat,
      lv_tabix type sy-tabix.


* Get tspat
  select *
         from tspat
         into corresponding fields of table it_tspat
         where spras eq sy-langu.

* Build Filter
  loop at it_tspat into wa_tspat.

    lv_tabix = sy-tabix.

    concatenate wa_tspat-spart
                wa_tspat-vtext
                into wa_tspat-filter.

    modify it_tspat from wa_tspat index lv_tabix.

  endloop.

* Sorting
  sort it_tspat by spart.


endmethod.


method get_list_tvkot.

data: wa_tvkot type ty_tvkot,
      lv_tabix type sy-tabix.


* Get TVKOT
  select *
         from tvkot
         into corresponding fields of table it_tvkot
         where spras eq sy-langu.

* Build Filter
  loop at it_tvkot into wa_tvkot.

    lv_tabix = sy-tabix.

    concatenate wa_tvkot-vkorg
                wa_tvkot-vtext
                into wa_tvkot-filter.

    modify it_tvkot from wa_tvkot index lv_tabix.

  endloop.

* Sorting
  sort it_tvkot by vkorg.

endmethod.


method get_list_tvtwt.

data: it_tvkov type standard table of tvkov,
      wa_tvkov type tvkov,
      wa_tvtwt type ty_tvtwt,
      lv_vkorg type vbak-vkorg,
      lv_tabix type sy-tabix.


* Get Current Sales Org
  read table it_parameters into wa_parameters with key parid = 'VKO'.

  if sy-subrc eq 0.
     lv_vkorg = wa_parameters-parva.
  else.
     get parameter id 'VKO' field lv_vkorg.
  endif.


* Get TVKOV
  select *
         from tvkov
         into table it_tvkov
         where vkorg eq lv_vkorg.

* Get TVTWT
  select *
         from tvtwt
         into corresponding fields of table it_tvtwt
         for all entries in it_tvkov
         where spras eq sy-langu
           and vtweg eq it_tvkov-vtweg.


* Build Filter
  loop at it_tvkov into wa_tvkov.

    loop at it_tvtwt into wa_tvtwt where vtweg eq wa_tvkov-vtweg.

      lv_tabix = sy-tabix.

      wa_tvtwt-vkorg = wa_tvkov-vkorg.

      concatenate wa_tvtwt-vtweg
                  wa_tvtwt-vkorg
                  wa_tvtwt-vtext
                  into wa_tvtwt-filter.

      modify it_tvtwt from wa_tvtwt index lv_tabix.

    endloop.

  endloop.

* Sorting
  sort it_tvtwt by vtweg.


endmethod.


method save.

data: it_return    type standard table of bapiret2,
      it_param_org type standard table of bapiparam,
      wa_param_org type bapiparam,
      lv_paramx    type bapiparamx.


* Delete duplicate
  delete adjacent duplicates from it_parameters comparing all fields.

  lv_paramx-parid = 'X'.
  lv_paramx-parva = 'X'.

* Get Data
  call function 'BAPI_USER_GET_DETAIL'
    exporting
      username             = sy-uname
      cache_results        = space
    tables
      parameter            = it_param_org
      return               = it_return.

* Merge Old with New
  loop at it_param_org into wa_param_org.

    read table it_parameters into wa_parameters with key parid = wa_param_org.

    if sy-subrc ne 0.
       append wa_param_org to it_parameters.
    endif.

  endloop.

* Save
  call function 'BAPI_USER_CHANGE'
    exporting
      parameterx              = lv_paramx
      username                = sy-uname
    tables
      parameter               = it_parameters
      return                  = it_return.



endmethod.


method set_filter.


* Plant
  wa_filter-paramid = 'WRK'.
  append wa_filter to it_filter.

* Purchase Organization
  wa_filter-paramid = 'EKO'.
  append wa_filter to it_filter.

* Purchase Group
  wa_filter-paramid = 'EKG'.
  append wa_filter to it_filter.

* Sales Organization
  wa_filter-paramid = 'VKO'.
  append wa_filter to it_filter.

* Distribution Channel
  wa_filter-paramid = 'VTW'.
  append wa_filter to it_filter.

* Division
  wa_filter-paramid = 'SPA'.
  append wa_filter to it_filter.


endmethod.
ENDCLASS.
