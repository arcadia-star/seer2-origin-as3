package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.utils.FightHelpUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MapProcessor_80540 extends FeiyuyiteMap {

    private static const NpcIds:Vector.<int> = Vector.<int>([785, 887]);

    private static const FightIds:Vector.<int> = Vector.<int>([1816, 1817]);

    private static const Positions:Vector.<Point> = Vector.<Point>([new Point(400, 230), new Point(483, 204)]);


    private var _petBagBtn:SimpleButton;

    private var _reBloodBtn:SimpleButton;

    private var _mobiles:Vector.<Mobile>;

    public function MapProcessor_80540(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this.hideLobbyMenu();
        this._mobiles = new Vector.<Mobile>();
        var _loc1_:int = 0;
        while (_loc1_ < 2) {
            this._mobiles.push(new Mobile());
            this._mobiles[_loc1_].resourceUrl = URLUtil.getNpcSwf(NpcIds[_loc1_]);
            this._mobiles[_loc1_].buttonMode = true;
            this._mobiles[_loc1_].addEventListener(MouseEvent.CLICK, this.toFight);
            this._mobiles[_loc1_].setPostion(Positions[_loc1_]);
            this._mobiles[_loc1_].height = 100;
            MobileManager.addMobile(this._mobiles[_loc1_], MobileType.NPC);
            _loc1_++;
        }
        new FightHelpUtil(this._petBagBtn, this._reBloodBtn);
        FightManager.addEventListener(FightStartEvent.FIGHT_OVER, this.overHandler);
    }

    private function onCompleteMap(param1:SceneEvent):void {
        if (SceneManager.active.mapID == 70) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteMap);
        }
    }

    override protected function toFight(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(476, "飞伊特", [[0, "哇，好冷清的地方，住这里的家伙一定每天都像望夫崖一样寂寞度日"]], ["……"], [function ():void {
            NpcDialog.show(785, "银翼亚斯", [[0, "这谁家的小孩，胡说啥呢【怒】"]], ["……"], [function ():void {
                NpcDialog.show(476, "飞伊特", [[0, "噫！飞翼氏族的SPT大人，小人错了，请原谅"]], ["……"], [function ():void {
                    NpcDialog.show(887, "风神卡多", [[0, "嘿，小鸭子，到今天的互殴时间了，我来啦！"]], ["……"], [function ():void {
                        NpcDialog.show(785, "银翼亚斯", [[0, "说多少遍了我叫银翼亚斯你才像鸭子瞧你这嘴和配色简直一脸鸭子！"]], ["……"], [function ():void {
                            NpcDialog.show(887, "风神卡多", [[0, "嘁，就爱图一时口舌之快，诶，这小家伙哪儿来的呀，怎么感觉前几天来找我打的那只有点相似……"]], ["……"], [function ():void {
                                NpcDialog.show(476, "飞伊特", [[0, "哇，风刃氏族的SPT大人，你好你好，前两天是我的哥哥风伊特去找你的呀，我也和他一样进化啦，现在安心的四处游玩中~"]], ["……"], [function ():void {
                                    NpcDialog.show(887, "风神卡多", [[0, "是嘛，你弟弟可是相当努力啊。来来来，让我们俩一块训练训练你，小亚斯忍住你的怒气，别对人家小孩下手太重！"]], ["……"], [function ():void {
                                        NpcDialog.show(785, "银翼亚斯", [[0, "哼，我还是知道这点事的，一会揍你。"]], ["……"], [function ():void {
                                            NpcDialog.show(476, "飞伊特", [[3, "【好像他俩之间有莫名的羁绊……】"]], ["我不想挨打……", "进入挑战"], [null, function ():void {
                                                FightManager.startFightWithWild(1839);
                                            }]);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function overHandler(param1:FightStartEvent):void {
        (SceneManager.active as LobbyScene).showToolbar();
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.overHandler);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function isCanFight():Boolean {
        var _loc2_:PetInfo = null;
        var _loc1_:Boolean = true;
        for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
            if ([19, 20, 21].indexOf(_loc2_.type) != -1) {
                _loc1_ = false;
                break;
            }
        }
        return _loc1_;
    }

    private function initFight():void {
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    override public function dispose():void {
    }
}
}
