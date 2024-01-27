package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.sevenDragonNinja.SevenDragonNinjaMap;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.utils.URLUtil;

public class MapProcessor_1181 extends MapProcessor {


    private var _mapHandler:SevenDragonNinjaMap;

    public function MapProcessor_1181(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.sendNovice("0x10034163");
        this._mapHandler = new SevenDragonNinjaMap(_map);
        ServerBufferManager.getServerBuffer(ServerBufferType.SEVEN_DRAGON_NINJA_MOVIE, function (param1:ServerBuffer):void {
            var buffer:ServerBuffer = param1;
            var count:int = buffer.readDataAtPostion(0);
            if (count < 1) {
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("SevenDragonNinjaMovie"), function ():void {
                    ServerBufferManager.updateServerBuffer(ServerBufferType.SEVEN_DRAGON_NINJA_MOVIE, 0, 1);
                });
            }
        });
    }

    override public function dispose():void {
        if (this._mapHandler) {
            this._mapHandler.dispose();
            this._mapHandler = null;
        }
        super.dispose();
    }
}
}
