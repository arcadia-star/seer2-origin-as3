package com.taomee.seer2.app.copy {
import com.taomee.seer2.app.controls.RightDownToolBar;
import com.taomee.seer2.app.copy.panelControl.CopyPanelControl;
import com.taomee.seer2.app.scene.PathScene;

public class CopyScene extends PathScene {


    public function CopyScene(param1:int) {
        super(param1);
    }

    override public function init():void {
        super.init();
        CopyPanelControl.getInstance().show();
    }

    override protected function onTick(param1:int):void {
        super.onTick(param1);
    }

    override protected function updateScene():void {
        super.updateScene();
    }

    private function updateRightDownToolBarState(param1:uint):void {
        RightDownToolBar.backBar();
    }

    override public function dispose():void {
        CopyPanelControl.getInstance().hide();
        super.dispose();
    }

    public function showToolbar():void {
    }

    public function hideToolbar():void {
    }

    public function hideTrailsToolBar():void {
    }
}
}
