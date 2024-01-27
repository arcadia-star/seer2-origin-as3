package com.taomee.seer2.app.activity.processor.threeEightDualFight {
import com.taomee.seer2.app.activity.processor.ActivityProcessor;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

public class ActivityMapHandler_310 extends ThreeEightDualFightMapHandler {


    private var _teleport:Teleport;

    public function ActivityMapHandler_310(param1:ActivityProcessor) {
        super(param1);
        this.processLayout();
        playActivityAnimation("threeEightDualFight/start");
    }

    private function processLayout():void {
        this._teleport = new Teleport();
        this._teleport.setData(<teleport name="三八擂台" pos="742,390" targetMapId="780"/>);
        SceneManager.active.mapModel.content.addChild(this._teleport);
    }

    override public function dispose():void {
        if (this._teleport) {
            DisplayObjectUtil.removeFromParent(this._teleport);
            this._teleport = null;
        }
        super.dispose();
    }
}
}
