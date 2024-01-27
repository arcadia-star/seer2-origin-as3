package com.taomee.seer2.app.lobby {
import com.taomee.seer2.app.controls.LeftTopToolBar;
import com.taomee.seer2.app.controls.MinorToolBar;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.scene.BigPathScene;
import com.taomee.seer2.app.scene.LobbyPanel;

public class BigLobbyScene extends BigPathScene {


    private var _mainSceneIdVec:Vector.<int>;

    public function BigLobbyScene(param1:int) {
        this._mainSceneIdVec = new <int>[10, 20, 30, 40, 50, 60, 70, 80];
        super(param1);
    }

    override public function init():void {
        super.init();
        LobbyPanel.instance.isShow = false;
    }

    override protected function onTick(param1:int):void {
        super.onTick(param1);
        LobbyPanel.instance.onUpdate();
    }

    override protected function updateScene():void {
        super.updateScene();
        LobbyPanel.instance.update(mapModel);
    }

    override public function dispose():void {
        LobbyPanel.instance.isShow = false;
        super.dispose();
    }

    public function showToolbar():void {
        ToolBar.show();
        PetAvatarPanel.show();
        MinorToolBar.show();
        RightToolbarConter.instance.show();
        LeftTopToolBar.show();
    }

    public function hideToolbar():void {
        ToolBar.hide();
        PetAvatarPanel.hide();
        MinorToolBar.hide();
        RightToolbarConter.instance.hide();
        LeftTopToolBar.hide();
    }

    public function hideTrailsToolBar():void {
        ToolBar.hide();
        MinorToolBar.hide();
        LeftTopToolBar.hide();
        RightToolbarConter.instance.hide();
    }
}
}
