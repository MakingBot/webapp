
function startJavascript(jquerySelector) {
    
    $(jquerySelector+' .toolTipFrom').tooltip({
        bodyHandler: function() {            
            return $('#'+$(this).attr('toolTipTo')).html();
        }, 
        showURL: false 
    });
    
    $(jquerySelector+' .dataTable').each(
        function(){
            $(this).dataTable(getDataTableOptions(this));
        });
    
    $(jquerySelector+' .popup').dialog(getDialogOptions(this));
}

$(document).ready(function() {
    startJavascript('');
});


function getDataTableOptions($obj){
    $aaSorting = '"aaSorting": [';
    $aoColumns = '"aoColumns": ['
    $aoColumnsDelim = '';
    
    $strOpt = '{';
    
    var ths = $($obj).find('th');
    for(var $i=0; $i<ths.length; $i++)
    {
        $thItem = $(ths[$i]);
        if($thItem.hasClass('defaultSortDesc'))
        {
            $aaSorting += '['+$thItem.index()+', "desc" ]';
        }
        
        if($thItem.hasClass('unsortable'))
        {
            $aoColumns += $aoColumnsDelim+'{ "bSortable": false }';
        }
        else
        {
            $aoColumns += $aoColumnsDelim+'null';
        }
        
        $aoColumnsDelim = ',';
    }
    
    $aaSorting += ']';
    $aoColumns += ']';
    
    $strOpt += $aaSorting +','+$aoColumns ;
    $strOpt += '}';
    
    eval('$options = '+$strOpt);
    
    return $options;
}

function getDialogOptions($obj){
    $strOpt = '{autoOpen: false, height: 300, width: 350, modal: true}';
    eval('$options = '+$strOpt);
    return $options
}

function openDialog(popup, params) {
    if (typeof params == "undefined") {
        params = '';
    }
    
    $('#'+popup).html(getWaitHtml());
    $('#'+popup).dialog('open');
    var page = ($('#'+popup).attr('page'));
    var $action = ($('#'+popup).attr('action'));
    
    $.ajax({
        url: 'webService.php',
        data: 'page='+page+'&'+'action='+$action+'&'+params,
        success: function(html){
            $('#'+popup).html(html);
        },
        error: function(a,b,c){
            debugger;
            alert('An error occured');
        }
    });
}

function sendRequest(page, response, params, jsonData, onSuccess, onError){
    if (typeof params == "undefined") {
        params = '';
    }
        
    $('#'+response).html(getWaitHtml());
    $('#'+response).show();
    $.ajax({
        url: 'webService.php?page='+page+'&'+params+'&jsonData='+JSON.stringify(jsonData),
        type: 'GET',
        success: function(html){
            $('#'+response).html(html);
            startJavascript('#'+response);
            if (onSuccess) { onSuccess(); }
        },
        error: function(a,b,c){
            alert('An error occured');
            if (onError) { onError(); }
        }
    });
}

function getWaitHtml(){
    return '<img src="html/img/wait.gif" alt="wait" />';
}

function reloadPage(){
     location.reload();
}