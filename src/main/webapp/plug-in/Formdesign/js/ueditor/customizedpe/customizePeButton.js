// 添加和pe系统相关的editor编辑按钮
UE.registerUI('插入发件人',function(editor,uiName){
    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "${发件人}");
        }
    });

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:uiName,
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -60px -20px;',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
           editor.execCommand(uiName);
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});

UE.registerUI('插入收件人',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "${收件人}");
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

UE.registerUI('插入跳转地址',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "${跳转地址}");
        }
    });
    var btn = new UE.ui.Button({
        name:uiName,
        title:uiName,
        cssRules :'background-position: -500px 0;',
        onclick:function () {
           editor.execCommand(uiName);
        }
    });
    return btn;
});

UE.registerUI('插入该节点的剩余时间',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "${剩余时间}");
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

UE.registerUI('插入事项名称',function(editor,uiName){
    editor.registerCommand(uiName,{
        execCommand:function(){
            this.execCommand('insertHtml', "${事项名称}");
        }
    });
    var btn = new UE.ui.Button({
        name:uiName,
        title:uiName,
        cssRules :'background-position: -520px 0;',
        onclick:function () {
           editor.execCommand(uiName);
        }
    });
    return btn;
});