function DalbitDataTable(dom, param, columnsInfo) {
    this.dom = dom;
    var url = columnsInfo.url;

    this.dataTableSource = {
        // dom: '<"top"<"text-right"i>><rt>p',
        destroy: true,                                                                   //테이블 파괴가능
        pageLength: 10,                                                                  // 한 페이지에 기본으로 보여줄 항목 수
        bPaginate: true,                                                                // 페이징 처리 여부.
        bLengthChange: true,                                                        //  페이지 표시 건수 변동 기능 사용 여부
        lengthMenu : [ [ 3, 5, 10, -1 ], [ 3, 5, 10, "All" ] ],                  // "bLengthChange" 리스트 항목을 구성할 옵션
        bAutoWidth: false,                                                            // 자동 Width 계산 여부
        processing: false,                                                              // Process 바 출력 여부
        ordering: true,                                                                 // 정렬 사용 여부
        serverSide: false,                                                             // 서버에서 정렬한 데이터 그대로 사용할지 여부 (false : 서버에서 정렬한 데이터도 client에서 다시 재정렬)
        searching: false,                                                               // 서칭 기능 사용 여부
        ajax : {
            'url':url,
            'type':"POST",
            'data': param
        },
        columnDefs: [
            {
                'targets': [0,1],
                'searchable': false,
                'orderable': false,
            },
            {
                'targets': 0,
                'className': 'dt-body-center',
                'render': function (data, type, full, meta) {
                    return '<input type="checkbox" name="id[]" value="' + $('<div/>').text(data).html() + '">';
                }
        }],
        columns : [
            {"title": "<input type=\"checkbox\" name=\"select_all\" value=\"1\" id=\""+ this.dom.prop("id") +"-select-all\" />" ,"data": null},
            {"title": "No.", "data": null, "width": "10px"},
        ],
        order: [[ 2, 'asc' ]]
    }

    var columnDefs = columnsInfo.columnDefs;
    var columns = columnsInfo.columns;

    if(!isEmpty(columnDefs)){
        this.dataTableSource.columnDefs = this.dataTableSource.columnDefs.concat(columnDefs);
    }

    if(!isEmpty(columns)){
        this.dataTableSource.columns = this.dataTableSource.columns.concat(columns);
    }

    // 체크박스 사용
    this.isUseCheckbox = true;
    // 넘버링 사용 여부
    this.isUseIndex = true;


    // ClickEvent
    this.arrayClickEvent = {};

    this.g_DataTable = null;
}








/* === Init =================================================================*/

    // Init DataTable
    DalbitDataTable.prototype.initDataTable = function (initFn) {
        this.dom.empty();

        var g_DataTable = this.dom.DataTable(this.dataTableSource);
        this.g_DataTable = g_DataTable;

        g_DataTable.column(0).visible(this.isUseCheckbox);
        g_DataTable.column(1).visible(this.isUseIndex);

        // index Number 생성
        g_DataTable.on('order.dt search.dt', function () {
            g_DataTable.column(1, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();

        this.initEvent();

        if(!isEmpty(initFn)){
            initFn();
        }

        return g_DataTable;
    }


    // Init Event
    DalbitDataTable.prototype.initEvent =  function (){
        var allCheckBox = $("#" + this.dom.prop("id") + "-select-all");
        var g_DataTable = this.dom.DataTable(this.dataTableSource);

        // Row Click Event
        var arrayClickEvent = this.arrayClickEvent;
        this.dom.children('tbody').on('click', 'td', function () {
            var idxColumn = $(this).index();
            var idxRow = $(this).parent("tr").index();
            var data = g_DataTable.row($(this).parent("tr")).data();


            if(!isEmpty(arrayClickEvent[idxColumn])){
                arrayClickEvent[idxColumn](idxRow, idxColumn, data);
                return;
            }

            if(!isEmpty(arrayClickEvent["-1"])){
                arrayClickEvent["-1"](idxRow, idxColumn, data);
                return;
            }
        });

        // 상단 CheckBox 전체 선택 Event
        allCheckBox.on('click', function () {
            var rows = this.dom.DataTable().rows({ 'search': 'applied' }).nodes();
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        // 전체 선택 이후 하위 CheckBox 해제 시 상단 CheckBox UI 변경 Event
        this.dom.children('tbody').on('change', 'input[type="checkbox"]', function () {
            if (!this.checked) {
                var el = allCheckBox.get(0);

                if (el && el.checked && ('indeterminate' in el)) {
                    el.indeterminate = true;
                }
            }
        });
    }





/* === Option =================================================================*/

    // DataTable Reload / Ajax 재호출
    DalbitDataTable.prototype.reload = function () {
        this.dom.DataTable().ajax.reload();
    }

    // DataTable Reload / Url, Data, Columns 초기화 후 Reload (기존 테이블 변경  시 사용)
    DalbitDataTable.prototype.changeReload = function (url, data, columnsInfo, initFn){
        if(!isEmpty(this.g_DataTable)){this.dom.DataTable().destroy();}
        this.dom.empty();

        if(!isEmpty(url)) {
            this.dataTableSource.ajax.url = url;
        }

        if(!isEmpty(data)) {
            this.dataTableSource.ajax.data = data;
        }

        var infoUrl = columnsInfo.url;
        var columnDefs = columnsInfo.columnDefs;
        var columns = columnsInfo.columns;

        if(!isEmpty(infoUrl)){
            this.dataTableSource.ajax.url = infoUrl;
        }

        if(!isEmpty(columnDefs)) {
            if(!isEmpty(this.dataTableSource.columnDefs)){
                this.dataTableSource.columnDefs = this.dataTableSource.columnDefs.slice(0,2);
                this.dataTableSource.columnDefs = this.dataTableSource.columnDefs.concat(columnDefs);
            }

            if(!isEmpty(this.dataTableSource.aoColumnDefs)){
                this.dataTableSource.aoColumnDefs = this.dataTableSource.aoColumnDefs.slice(0,2);
                this.dataTableSource.aoColumnDefs = this.dataTableSource.aoColumnDefs.concat(columnDefs);
            }
        }

        if(!isEmpty(columns)) {
            if(!isEmpty(this.dataTableSource.columns)){
                this.dataTableSource.columns = this.dataTableSource.columns.slice(0,2);
                this.dataTableSource.columns = this.dataTableSource.columns.concat(columns);
            }

            if(!isEmpty(this.dataTableSource.aoColumns)){
                this.dataTableSource.aoColumns = this.dataTableSource.aoColumns.slice(0,2);
                this.dataTableSource.aoColumns = this.dataTableSource.aoColumns.concat(columns);
            }
        }

        this.initDataTable(initFn);
    }

    DalbitDataTable.prototype.destroy = function(){
        if(!isEmpty(this.g_DataTable)){
            this.dom.DataTable().destroy();
        }
    }





/* === Getter =================================================================*/

    /* DataTable Source  */
    DalbitDataTable.prototype.getSource = function () {
        return this.dataTableSource;
    };

    /* getData(Array) from CheckBox  */
    DalbitDataTable.prototype.getCheckedData = function (){
        var arrayData = new Array;

        this.dom.children('tbody').find('input[type="checkbox"]').each(function () {
            if (this.checked) {
                var data = this.dom.DataTable().row($(this).parent("td").parent("tr")).data();
                arrayData.push(data);
            }
        });

        return arrayData;
    }

    /* get Row Idx Data  */
    DalbitDataTable.prototype.getDataRow = function (idxRow) {
        dalbitLog(this.dom.DataTable().row(idxRow).data());
        return this.dom.DataTable().row(idxRow).data();
    }

    /* get Rows Size  */
    DalbitDataTable.prototype.getRowSize = function(){
        dalbitLog(this.dom.DataTable().row()[0].length);
        return this.dom.DataTable().row()[0].length;
    }





/* === Setter =================================================================*/

    /* DataTable Source  */
    DalbitDataTable.prototype.setSource = function (dataTableSource) {
        this.dataTableSource = dataTableSource;
    };

    /* set Ajax URL  */
    DalbitDataTable.prototype.setURL = function (url) {
        this.dataTableSource.ajax.url = url;
    }

    /* set Use CheckBox  */
    DalbitDataTable.prototype.useCheckBox = function (isUse) {
        this.isUseCheckbox = isUse;
    }

    /* set Use Index  */
    DalbitDataTable.prototype.useIndex = function (isUse) {
        this.isUseIndex = isUse;
    }

    DalbitDataTable.prototype.setPageLength = function(pageLength){
        this.dataTableSource.pageLength = pageLength;
    }

    /* set Search Visible */
    DalbitDataTable.prototype.useSearch = function (isUse) {
        this.dataTableSource.searching = isUse;
    }

    /* set Row Click Event 함수 지정, 이벤트 column 지정 */
    DalbitDataTable.prototype.setEventClick = function (eventFnc, column) {
        if(isEmpty(eventFnc)){
            dalbitLog("[DalbitDataTable.prototype.setEventClick] eventFnc is Null!!");
            return;
        }

        var inputEvent = this.arrayClickEvent;

        if(!isEmpty(column)){
            var arrayColumn = column.toString().split(",");

            for(var idx=0; idx < arrayColumn.length; idx++){
                inputEvent[(arrayColumn[idx])] = eventFnc;
            }
        }else{
            inputEvent["-1"] = eventFnc;
        }

        this.arrayClickEvent = inputEvent;
    }