package com.taomee.seer2.app.processor.quest.handler.branch.quest10220 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10220_80135 extends QuestMapHandler {

    public static var isGame:Boolean;


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    public function QuestMapHandler_10220_80135(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10220) && QuestManager.isStepComplete(10220, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        _map.front.addChild(this._mc1);
        MovieClipUtil.playMc(this._mc1, 2, this._mc1.totalFrames, function ():void {
            NpcDialog.show(351, "冰系氏族小孩", [[0, "哇！是雷伊！"]], ["雷伊永远都是那么帅！"], [function ():void {
                NpcDialog.show(477, "雷伊", [[0, "我已经听到了你的祷告，放心，我们战神联盟一定会维护星球的和平的！"]], ["哇塞，战神联盟都出动了！"], [function ():void {
                    NpcDialog.show(351, "冰系氏族小孩", [[0, "太好了，雷伊！但是……"]], ["但是?"], [function ():void {
                        NpcDialog.show(477, "雷伊", [[0, "但是什么？"]], ["难道还有别的事？"], [function ():void {
                            NpcDialog.show(351, "冰系氏族小孩", [[0, "你能过来一下吗？"]], ["雷伊，快去看看吧！"], [function ():void {
                                DisplayUtil.removeForParent(_mc1);
                                _mc2 = _processor.resLib.getMovieClip("mc2");
                                _map.front.addChild(_mc2);
                                MovieClipUtil.playMc(_mc2, 2, _mc2.totalFrames, function ():void {
                                    DisplayUtil.removeForParent(_mc2);
                                    NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "啊，雷伊被抓走了，该怎么办呢？"]], ["快去找找有什么线索吧。"], [function ():void {
                                        _mc3 = _processor.resLib.getMovieClip("mc3");
                                        _map.front.addChild(_mc3);
                                        MovieClipUtil.playMc(_mc3, 2, _mc3.totalFrames, function ():void {
                                            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "咦~S你来的正好，你有看到萨伦帝国的人吗？"]], ["……"], [function ():void {
                                                NpcDialog.show(14, "S", [[0, "是的，我刚看到一伙萨伦士兵好像把谁抓走了。"]], ["可恶的萨伦帝国设下陷阱把雷伊给抓走了。"], [function ():void {
                                                    NpcDialog.show(14, "S", [[0, "是吗？竟然把雷伊抓走了……"]], ["对啊，你知道他们去哪里了吗？"], [function ():void {
                                                        NpcDialog.show(14, "S", [[0, "放心，当时我就觉得不妙，所以派了奥黛丽和赫本去追踪他们了。"]], ["太好了，S，你真聪明啊！"], [function ():void {
                                                            NpcDialog.show(14, "S", [[0, "现在不是夸奖的时候，赶紧去救雷伊吧！"]], ["好的，走吧！"], [function ():void {
                                                                isGame = false;
                                                                ModuleManager.addEventListener("Quest10220Panel", ModuleEvent.HIDE, onHide);
                                                                ModuleManager.toggleModule(URLUtil.getAppModule("Quest10220Panel"), "正在打开...");
                                                            }]);
                                                        }]);
                                                    }]);
                                                }]);
                                            }]);
                                        }, true);
                                    }]);
                                }, true);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }, true);
    }

    private function onHide(param1:ModuleEvent):void {
        var event:ModuleEvent = param1;
        ModuleManager.removeEventListener("Quest10220Panel", ModuleEvent.HIDE, this.onHide);
        if (isGame) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(10220, 1);
        } else {
            AlertManager.showConfirm("啊呀，一不小心失败了哦，再来一次吧！", function ():void {
                ModuleManager.addEventListener("Quest10220Panel", ModuleEvent.HIDE, onHide);
                ModuleManager.toggleModule(URLUtil.getAppModule("Quest10220Panel"), "正在打开...");
            }, function ():void {
                _processor.showMouseHintAt(327, 200);
                _mc3.buttonMode = true;
                _mc3.addEventListener(MouseEvent.CLICK, onMC3);
            });
        }
    }

    private function onMC3(param1:MouseEvent):void {
        _processor.hideMouseClickHint();
        this._mc3.removeEventListener(MouseEvent.CLICK, this.onMC3);
        ModuleManager.addEventListener("Quest10220Panel", ModuleEvent.HIDE, this.onHide);
        ModuleManager.toggleModule(URLUtil.getAppModule("Quest10220Panel"), "正在打开...");
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.COPY, 80136);
    }

    override public function processMapDispose():void {
        if (_processor) {
            _processor.hideMouseClickHint();
        }
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mc2);
        if (this._mc3) {
            this._mc3.removeEventListener(MouseEvent.CLICK, this.onMC3);
        }
        ActorManager.getActor().isShow = true;
        DisplayUtil.removeForParent(this._mc3);
        ModuleManager.removeEventListener("Quest10220Panel", ModuleEvent.HIDE, this.onHide);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }
}
}
