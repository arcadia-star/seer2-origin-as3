package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.controls.widget.YueseNonoWidgetClick;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class Quest1InitNono {

    private static var _mc:MovieClip;


    public function Quest1InitNono() {
        super();
    }

    public static function setup():void {
        var time:uint;
        var endTime:uint;
        if (!NewPlayerGuideTimeManager.timeCheckNewGuide() && QuestManager.isAccepted(83) && QuestManager.isStepComplete(83, 9) && !QuestManager.isStepComplete(83, 10)) {
            Connection.addCommandListener(CommandSet.FIGHT_END_1507, processor);
        }
        time = new Date(2014, 1, 20).getTime() / 1000;
        endTime = new Date(2014, 8, 19).getTime() / 1000;
        if (ActorManager.actorInfo.createTime < time || ActorManager.actorInfo.createTime > endTime) {
            DisplayUtil.removeForParent(ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO));
        } else {
            ActiveCountManager.requestActiveCountList([203855, 203863], function (param1:Parser_1142):void {
                if ((param1.infoVec[0] & 64) == 64 && param1.infoVec[1] == 1) {
                    DisplayUtil.removeForParent(ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO));
                }
            });
        }
    }

    private static function processor(param1:MessageEvent):void {
        var event:MessageEvent = param1;
        setTimeout(function ():void {
            var _loc2_:PetInfo = null;
            var _loc1_:Boolean = false;
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
                if (_loc2_.resourceId == 824 && _loc2_.level >= 60) {
                    _loc1_ = true;
                }
            }
            if (_loc1_) {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onStepComplete);
                QuestManager.completeStep(83, 10);
            }
        }, 1000);
    }

    private static function onStepComplete(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, onStepComplete);
        Connection.removeCommandListener(CommandSet.FIGHT_END_1507, processor);
        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("NewQuestActivity"), function ():void {
            var _loc1_:Object = new Object();
            _loc1_.index = 8;
            ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"), "", _loc1_);
        });
        StatisticsManager.newSendNovice("新手引导tyler版", "2014上半年版新手引导tyler版", "完成成长试炼3");
    }

    private static function onInitLoginGift(param1:ServerBuffer):void {
        if (param1.readDataAtPostion(0) == 1) {
            DisplayUtil.removeForParent(ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO));
        }
    }

    private static function onInitLoginGift2(param1:ServerBuffer):void {
        if (param1.readDataAtPostion(0) != 1) {
            QueueLoader.load(URLUtil.getRes("quest/sceneAnimation/nono1.swf"), LoadType.SWF, onResLoaded);
        }
    }

    private static function onResLoaded(param1:ContentInfo):void {
        var info:ContentInfo = param1;
        _mc = DomainUtil.getMovieClip("item", info.domain);
        SceneManager.active.mapModel.front.addChild(_mc);
        ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO).visible = false;
        MovieClipUtil.playMc(_mc, 2, _mc.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc);
            DisplayUtil.removeForParent(ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO));
            ServerBufferManager.updateServerBuffer(ServerBufferType.INIT_LOGIN_GIFT, 0, 1);
        });
    }

    public static function click():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"), "正在打开...");
    }
}
}
