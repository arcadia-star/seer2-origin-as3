package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

public class MapProcessor_80076 extends MapProcessor {


    private var POSITIONs:Array;

    private var npcIdList:Array;

    private var moblieList:Vector.<Mobile>;

    public function MapProcessor_80076(param1:MapModel) {
        this.POSITIONs = [new Point(190, 460), new Point(188, 370), new Point(312, 328), new Point(482, 315), new Point(650, 330), new Point(780, 370), new Point(775, 480)];
        this.npcIdList = [653, 655, 656, 657, 658, 659, 654];
        super(param1);
    }

    override public function init():void {
        super.init();
        ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57, this.getFullState);
        this.moblieList = new Vector.<Mobile>();
        var _loc1_:int = 0;
        while (_loc1_ < 7) {
            this.moblieList.push(new Mobile());
            this.moblieList[_loc1_].resourceUrl = URLUtil.getNpcSwf(this.npcIdList[_loc1_]);
            this.moblieList[_loc1_].buttonMode = true;
            this.moblieList[_loc1_].addEventListener(MouseEvent.CLICK, this.toFight);
            this.moblieList[_loc1_].setPostion(this.POSITIONs[_loc1_]);
            this.moblieList[_loc1_].height = 100;
            MobileManager.addMobile(this.moblieList[_loc1_], MobileType.NPC);
            _loc1_++;
        }
    }

    override public function dispose():void {
        super.dispose();
        var _loc1_:int = 0;
        while (_loc1_ < 7) {
            this.moblieList[_loc1_].removeEventListener(MouseEvent.CLICK, this.toFight);
            MobileManager.removeMobile(this.moblieList[_loc1_], MobileType.NPC);
            _loc1_++;
        }
    }

    private function getFullState(param1:ServerBuffer):void {
        var buffer:ServerBuffer = param1;
        if (buffer.readDataAtPostion(35) == 0) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("PurgatoryFightFull"), function ():void {
                ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_57, 35, 1);
            }, true, true);
        }
    }

    private function toFight(param1:MouseEvent):void {
        var _loc2_:int = this.moblieList.indexOf(param1.target as Mobile);
        ModuleManager.toggleModule(URLUtil.getAppModule("PurgatoryFightPanel"), "", _loc2_);
    }
}
}
