package com.taomee.seer2.app.processor.activity.ChickenPK {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class ChickenPkManager {


    private var _map:MapModel;

    private var _npc:Mobile;

    private var _stage:MovieClip;

    public function ChickenPkManager(param1:MapModel) {
        super();
        this._map = param1;
        this.init();
    }

    private function init():void {
        this._npc = MobileManager.getMobile(54, MobileType.NPC);
        this._npc.buttonMode = true;
        this._stage = this._map.content["myStage"];
        this._stage.buttonMode = true;
        this.initEvent();
    }

    private function initEvent():void {
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
    }

    private function onNpcClick(param1:MouseEvent):void {
        NpcDialog.show(54, "周扒皮", [[0, "少废话！看比赛？胜者为王！这就是沙爪氏族当之无愧的“鸡”毛与沙！"]], ["观看斗鸡比赛", "囧，一会再来"], [this.watch]);
    }

    private function watch():void {
        if (ActorManager.actorInfo.coins < 800) {
            NpcDialog.show(54, "周扒皮", [[0, "捣什么乱！一边去！多赚点赛尔豆再来找我吧！"]], ["哼！神奇什么……"]);
        } else {
            NpcDialog.show(54, "周扒皮", [[0, "叫" + ActorManager.actorInfo.nick + "是吧？我们这里的规矩就是观看比赛需要押注！你必须要选一只你觉得会胜利的蛋壳鸡。三局两胜！有异议吗？准备好了？"]], ["准备就绪……", "我还是先看看（返回）"], [this.go, this.onNext]);
        }
    }

    private function onNext():void {
        this.onNpcClick(null);
    }

    private function go():void {
        Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, this.onInitCount);
        Connection.send(CommandSet.DAILY_LIMIT_1065, 269);
    }

    private function onInitCount(param1:MessageEvent):void {
        var _loc3_:Object = null;
        var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
        if (_loc2_.id == 269) {
            Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onInitCount);
            if (_loc2_.count >= 10) {
                NpcDialog.show(54, "周扒皮", [[0, "今天投注的次数已经超过10次啦，明天再来把"]], ["嗯，明天再来"]);
            } else {
                _loc3_ = new Object();
                _loc3_.cookback = this.cookback;
                ModuleManager.showModule(URLUtil.getAppModule("FightChickenPanel"), "正在打开斗鸡面板...", _loc3_);
            }
        }
    }

    private function cookback():void {
        NpcDialog.show(54, "周扒皮", [[0, "叫" + ActorManager.actorInfo.nick + "是吧？我们这里的规矩就是观看比赛需要押注！你必须要选一只你觉得会胜利的蛋壳鸡。三局两胜！有异议吗？准备好了？"]], ["准备就绪……", "我还是先看看（返回）"], [this.go, this.onNext]);
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onInitCount);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        this._stage.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        this._npc = null;
        this._stage = null;
    }
}
}
