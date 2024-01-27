package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_930 extends MapProcessor {


    private var _teleport:Teleport;

    private var toBtn:MovieClip;

    public function MapProcessor_930(param1:MapModel) {
        super(param1);
    }

    public function get teleport():Teleport {
        return this._teleport;
    }

    override public function init():void {
        super.init();
        this._teleport = AnimateElementManager.getElement(3) as Teleport;
        this._teleport.visible = false;
        this.toBtn = _map.content["to950"];
        this.toBtn.buttonMode = true;
        this.toBtn.addEventListener(MouseEvent.CLICK, this.showTeleport);
    }

    override public function dispose():void {
        super.dispose();
        this.toBtn.removeEventListener(MouseEvent.CLICK, this.showTeleport);
    }

    private function showTeleport(param1:MouseEvent):void {
        var mc:MovieClip = null;
        var event:MouseEvent = param1;
        mc = _map.content["machineMc"];
        this.toBtn.mouseEnabled = false;
        this.toBtn.buttonMode = false;
        this.toBtn.removeEventListener(MouseEvent.CLICK, this.showTeleport);
        MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
            mc.gotoAndStop(1);
            _teleport.visible = true;
        });
    }
}
}
