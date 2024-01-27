package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.IDataInput;

public class XinXueQiDianLi {


    private var _mapModel:MapModel;

    private var jiasiding:Mobile;

    private const jia_si_ding_id:int = 153;

    private const have_got_eff_id:int = 203849;

    private const swap_egg_id:int = 2517;

    private const panelname:String = "HolyIceActPanel";

    public function XinXueQiDianLi(param1:MapModel) {
        super();
        this._mapModel = param1;
        this.jiasiding = MobileManager.getMobile(this.jia_si_ding_id, MobileType.NPC);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.unitClickHandler);
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.dialogShowHandler);
    }

    protected function dialogShowHandler(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content == 153) {
            ServerBufferManager.getServerBuffer(205, function (param1:ServerBuffer):void {
                var buffer:ServerBuffer = param1;
                var count:int = buffer.readDataAtPostion(0);
                if (count == 0) {
                    MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("XinXueQiDianLi"), function ():void {
                        ServerBufferManager.updateServerBuffer(205, 0, 1);
                    });
                }
            });
        }
    }

    private function unitClickHandler(param1:DialogPanelEvent):void {
        switch (param1.content.params) {
            case "zhan_zhang_te_xun":
                this.texun();
                break;
            case "zhi_hui_kao_yan":
                this.kaoyan();
                break;
            case "ling_pa_la_ding":
                this.getegg();
        }
    }

    private function texun():void {
        NpcDialog.show(this.jia_si_ding_id, "贾斯汀", [[1, ActorManager.actorInfo.nick + ",不知道这个寒假你的精灵训练的怎么样了？就让我和克拉克站长为你的精灵做一次特别训练吧！"]], ["点击克拉克旁边装置开始训练", "我不练了，去写作业了"], [function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 60);
        }]);
    }

    private function kaoyan():void {
        NpcDialog.show(this.jia_si_ding_id, "贾斯汀", [[0, ActorManager.actorInfo.nick + ",关于约瑟传说的知识你掌握了多少？敢不敢让我贾斯汀站长来考验一下？放心，题目不难的，答对有奖。"]], ["好！尽管问！", "站长,我妈妈说我很笨"], [function ():void {
            ModuleManager.toggleModule(URLUtil.getAppModule("SeerIIAnswerPanel"), "正在问答面板...");
        }]);
    }

    private function getegg():void {
        ActiveCountManager.requestActiveCountList([this.have_got_eff_id], function (param1:Parser_1142):void {
            var gotEgg:int = 0;
            var par:Parser_1142 = param1;
            gotEgg = int(par.infoVec[0]);
            NpcDialog.show(jia_si_ding_id, "贾斯汀", [[4, "终于要送出这份大礼了！帕拉丁蛋会孵化出精灵帕拉丁，还能与其他精灵合体成为圣冰骑士！这次我只带来50000个帕拉丁蛋，先领先得！"]], ["我要领！"], [function ():void {
                if (gotEgg > 0) {
                    NpcDialog.show(jia_si_ding_id, "贾斯汀", [[0, "你已经领过喽，每个小赛尔只能领1枚帕拉丁蛋哦。 "]], ["是！站长！"]);
                } else {
                    SwapManager.swapItem(swap_egg_id, 1, function (param1:IDataInput):void {
                        var data:IDataInput = param1;
                        new SwapInfo(data);
                        NpcDialog.show(jia_si_ding_id, "贾斯汀", [[4, "帕拉丁蛋已经放入你的背包了，快去看看吧。记住，帕拉丁蛋还可以合成为圣冰骑士！一定要好好珍惜它！"]], ["马上合体圣冰骑士！", "是！站长！"], [function ():void {
                            ModuleManager.showAppModule(panelname);
                        }]);
                    }, function (param1:*):void {
                        NpcDialog.show(jia_si_ding_id, "贾斯汀", [[1, "哦，好可惜，你来晚一步，帕拉丁蛋已经领完了。别难过，下次我还会带更棒的礼物给你的。"]], ["哎。。。我妈妈总说我慢腾腾的。"]);
                    });
                }
            }]);
        });
    }

    public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW, this.dialogShowHandler);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.unitClickHandler);
    }
}
}
