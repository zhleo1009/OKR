UE.registerUI('主题',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "{流程标题:title}");
        }
    });

    var btn = new UE.ui.Button({
        name:uiName,
        title:uiName,
        cssRules :'background-position: -801px -41px;',
        onclick:function () {
           editor.execCommand(uiName);
        }
    });

    return btn;
});


UE.registerUI('发起人',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "{发起人:startUser}");
        }
    });
    var btn = new UE.ui.Button({
        name:uiName,
        title:uiName,
        cssRules :'background-position: -60px -20px;',
        onclick:function () {
           editor.execCommand(uiName);
        }
    });
    return btn;
});


UE.registerUI('开始日期',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "{开始日期:startDate}");
        }
    });
    var btn = new UE.ui.Button({
        name:uiName,
        title:uiName,
        cssRules :'background-position: -140px -20px;',
        onclick:function () {
           editor.execCommand(uiName);
        }
    });
    return btn;
});

UE.registerUI('开始时间',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "{开始时间:startTime}");
        }
    });
    var btn = new UE.ui.Button({
        name:uiName,
        title:uiName,
        cssRules :'background-position: -160px -20px;',
        onclick:function () {
           editor.execCommand(uiName);
        }
    });
    return btn;
});
