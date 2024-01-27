package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class MapProcessor_3835 extends MapProcessor {


    private var _tm:Timer;

    private var _curIdx:int = 1;

    public function MapProcessor_3835(param1:MapModel) {
        this._tm = new Timer(5000);
        super(param1);
    }

    override public function dispose():void {
        this._tm.stop();
        this._tm.removeEventListener(TimerEvent.TIMER, this.onChangePicture);
        this._tm = null;
    }

    override public function init():void {
        this.pictureMc();
        (_map.content["teleportMc"] as MovieClip).addEventListener(MouseEvent.CLICK, this.onTeleport);
        (_map.content["npcMc"] as MovieClip).addEventListener(MouseEvent.CLICK, this.onNpc);
    }

    private function onTeleport(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function onNpc(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(1026, "伊鲁维塔将军", [[0, "这里是阿尔达要塞，人类最后的净土。"]], ["我们一定会拯救人类！"], [function ():void {
        }]);
    }

    private function pictureMc():void {
        this._tm.addEventListener(TimerEvent.TIMER, this.onChangePicture);
        this._tm.start();
        MovieClip(_map.content["picMc"]).gotoAndStop(1);
        MovieClip(_map.content["picMc"]).buttonMode = true;
        MovieClip(_map.content["picMc"]).addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        this._tm.stop();
        this.onChangePicture(null);
        this._tm.reset();
        this._tm.start();
    }

    private function onChangePicture(param1:Event):void {
        ++this._curIdx;
        if (this._curIdx >= 5) {
            this._curIdx = 1;
        }
        MovieClip(_map.content["picMc"]).gotoAndStop(this._curIdx);
    }
}
}
