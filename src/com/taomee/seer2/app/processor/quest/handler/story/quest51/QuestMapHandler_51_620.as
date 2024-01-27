package com.taomee.seer2.app.processor.quest.handler.story.quest51 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_51_620 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    public function QuestMapHandler_51_620(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.initMc();
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initNPC();
        }
    }

    private function initMc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.NpcTalkHandler);
    }

    private function NpcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(123, "文森特", [[0, "坦白说，在我的记忆力根本没有“蒂芙伦”这个人……"]], ["也许真的是太大众脸了……？"], [function ():void {
            NpcDialog.show(123, "文森特", [[0, "…………（仿佛在思索着什么）"]], ["（总让人觉得有点蹊跷）"], [function ():void {
                _mc_1 = _processor.resLib.getMovieClip("mc_1");
                _map.front.addChild(_mc_1);
                MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, AcceptHandler);
                    QuestManager.accept(_quest.id);
                }, true);
            }]);
        }]);
    }

    private function AcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
        this.NpcTalk();
    }

    private function initNPC():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_2");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.NpcTalkAgainHandler);
        this._mc_1 = _processor.resLib.getMovieClip("mc_3");
        _map.content.addChild(this._mc_1);
    }

    private function NpcTalkAgainHandler(param1:MouseEvent):void {
        this.NpcTalk();
    }

    private function NpcTalk():void {
        NpcDialog.show(122, "派瑞", [[2, "虽然詹姆斯唱歌总是走调，又矮……但是他是我最好的伙伴啊！怎么就不见了呢！"]], ["会不会是去哪儿玩了？"], [function ():void {
            NpcDialog.show(122, "派瑞", [[2, "我已经四处找过了，都没有他的踪影。"]], ["这个……"], [function ():void {
                _mc_2 = _processor.resLib.getMovieClip("mc_4");
                _map.content.addChild(_mc_2);
                MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                    NpcDialog.show(122, "派瑞", [[0, "刚才那个是什么声音？好像是歌声？"]], ["（我怎么觉得是从蒂芙伦身上飘出来的……）"], [function ():void {
                        NpcDialog.show(114, "蒂芙伦", [[0, "呃不，派瑞大人你一定是听错了。况且我不会唱歌，呵，呵呵……"]], ["（好像很心虚？）"], [function ():void {
                            NpcDialog.show(123, "文森特", [[0, "我没听错的话，是詹姆斯的声音。"]], ["真的？（声音的方位不对啊……）"], [function ():void {
                                NpcDialog.show(114, "蒂芙伦", [[0, "文森特大人，派瑞大人……我来是想告诉你们，冰封酋长的冰块找到了，就在冰脊之巅。"]], ["当务之急，先去冰脊之巅看看！"], [function ():void {
                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, StepOneHandler);
                                    QuestManager.completeStep(_quest.id, 1);
                                }]);
                            }]);
                        }]);
                    }]);
                }, true);
            }]);
        }]);
    }

    private function StepOneHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.StepOneHandler);
        SceneManager.changeScene(SceneType.LOBBY, 640);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.StepOneHandler);
    }
}
}
