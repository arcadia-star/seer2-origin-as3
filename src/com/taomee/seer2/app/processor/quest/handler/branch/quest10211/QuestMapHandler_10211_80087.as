package com.taomee.seer2.app.processor.quest.handler.branch.quest10211 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.geom.Point;

public class QuestMapHandler_10211_80087 extends QuestMapHandler {


    private var _barry:Mobile;

    private var _hello:Mobile;

    public function QuestMapHandler_10211_80087(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isStepComplete(10211, 3) == true && QuestManager.isStepComplete(10211, 4) == false) {
            this.initStep4();
        } else if (QuestManager.isStepComplete(10211, 4) == true && QuestManager.isStepComplete(10211, 5) == false) {
            this.initStep5();
        }
    }

    private function initStep4():void {
        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10211_3"), 6, [[1, 0]], function ():void {
            createBarry();
            NpcDialog.show(10, "巴蒂", [[0, "拜瑞又是你，感谢你再次帮助我们！"]], ["是的，你又救了我们一次"], [function ():void {
                NpcDialog.show(668, "拜瑞", [[0, "你们赶快离开这里吧，这里很危险，魔界四将并不是好惹的！"]], ["可是…"], [function ():void {
                    NpcDialog.show(10, "巴蒂", [[0, "多罗到现在还没有醒过来，谁来救救他吧~55555……"]], ["多罗你快醒醒啊"], [function ():void {
                        NpcDialog.show(668, "拜瑞", [[0, "吵什么吵"]], ["你有办法救救多罗吗?"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep4);
                            QuestManager.completeStep(10211, 4);
                        }]);
                    }]);
                }]);
            }]);
        });
    }

    private function onStep4(param1:QuestEvent):void {
        if (param1.questId == 10211 && param1.stepId == 4) {
            this.createHello();
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep4);
            this.initStep5();
        }
    }

    private function initStep5():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10211_4"), function ():void {
            NpcDialog.show(668, "拜瑞", [[0, "海罗，接下来就拜托你了!"]], ["海罗可以救多罗吗？"], [function ():void {
                NpcDialog.show(662, "海罗", [[0, "好的，愿圣灵与你们同在!"]], ["阿门？"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10211_5"), function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onStep5);
                        QuestManager.completeStep(10211, 5);
                    }, true, true);
                }]);
            }]);
        }, true, true);
    }

    private function onStep5(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep5);
        SceneManager.changeScene(SceneType.LOBBY, 3812);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep4);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep5);
        if (this._barry) {
            DisplayObjectUtil.removeFromParent(this._barry);
        }
        if (this._hello) {
            DisplayObjectUtil.removeFromParent(this._hello);
        }
    }

    private function createBarry():void {
        if (!this._barry) {
            this._barry = new Mobile();
            this._barry.width = 100;
            this._barry.height = 160;
            this._barry.setPostion(new Point(460, 325));
            this._barry.resourceUrl = URLUtil.getNpcSwf(668);
            this._barry.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._barry.label = "拜瑞";
            this._barry.labelImage.y = -this._barry.height - 10;
            this._barry.buttonMode = true;
            MobileManager.addMobile(this._barry, MobileType.NPC);
        }
    }

    private function createHello():void {
        if (!this._hello) {
            this._hello = new Mobile();
            this._hello.width = 100;
            this._hello.height = 160;
            this._hello.setPostion(new Point(618, 343));
            this._hello.resourceUrl = URLUtil.getNpcSwf(669);
            this._hello.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._hello.label = "海罗";
            this._hello.labelImage.y = -this._hello.height - 10;
            this._hello.buttonMode = true;
            MobileManager.addMobile(this._hello, MobileType.NPC);
        }
    }
}
}
