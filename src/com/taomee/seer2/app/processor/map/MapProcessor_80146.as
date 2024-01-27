package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.constant.PetTypeNameMap;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

import org.taomee.utils.BitUtil;

public class MapProcessor_80146 extends MapProcessor {


    private const TURN_ID:uint = 203754;

    private const NPC_ID1:uint = 710;

    private const NPC_ID2:uint = 711;

    private const FIGHT_ID:Array = [822, 823, 824];

    private const NEW_FIGHT_ID:Array = [1379, 1380, 1381];

    private const WAR_PO:uint = 203784;

    private const PET_TYPE:Array = [15, 2, 3, 4, 9, 16, 5, 11, 17, 13, 18, 12, 14, 7, 8, 10, 6];

    private var npcId:uint = 0;

    private var bossNpc:Mobile;

    private var warPo:uint;

    public function MapProcessor_80146(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.createNpc();
    }

    private function getTurn(param1:Parser_1142):void {
        this.warPo = param1.infoVec[0];
        this.createNpc();
    }

    private function createNpc():void {
        this.bossNpc = new Mobile();
        this.bossNpc.resourceUrl = URLUtil.getNpcSwf(888);
        this.bossNpc.buttonMode = true;
        this.bossNpc.x = 545;
        this.bossNpc.y = 430;
        this.bossNpc.addEventListener(MouseEvent.CLICK, this.toFight);
        MobileManager.addMobile(this.bossNpc, MobileType.NPC);
    }

    protected function toFight(param1:MouseEvent):void {
        ModuleManager.showAppModule("SpriteKingEvolutionScenePanel");
    }

    private function showDia1():void {
        NpcDialog.show(this.NPC_ID1, "约瑟", [[0, "与奎尔斯的那场大战给阿卡迪亚留下了永恒的疤痕，正义需要勇气和力量！"]], ["直接挑战！", "了解规则", "离开"], [function ():void {
            ModuleManager.showAppModule("FightYueSeWangPanel");
        }, function ():void {
            NpcDialog.show(NPC_ID1, "约瑟", [[0, "我会抽取一些系别出来，你必须具有对应的王魄才能携带这些系别的精灵参战！"]], ["只能携带我拥有王魄的系别吗？"], [function ():void {
                NpcDialog.show(NPC_ID1, "约瑟", [[0, "然后我会抽选出3只灵兽，只要你拥有我选中的灵兽，它就可以不作为你的对手！你准备好了吗？"]], ["我有备而来", "算了！我再练练吧！"], [function ():void {
                    ModuleManager.showAppModule("FightYueSeWangPanel");
                }]);
            }]);
        }]);
    }

    private function checkIsInTime():Boolean {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc2_:int = _loc1_.fullYear;
        var _loc3_:int = _loc1_.month;
        var _loc4_:int = _loc1_.date;
        var _loc5_:int = _loc1_.hours;
        var _loc6_:int = _loc1_.minutes;
        var _loc7_:Boolean;
        if (_loc7_ = _loc2_ == 2014 && _loc3_ == 9 && _loc4_ == 1) {
            return true;
        }
        return false;
    }

    private function showDia2():void {
        NpcDialog.show(this.NPC_ID2, "约瑟", [[0, "看来你通过了灵兽们的考验！接下来你的对手将是我！做好准备了吗？"]], ["准备好了", "离开一会"], [function ():void {
            var index:* = undefined;
            index = Math.floor(Math.random() * 3);
            if (canFight()) {
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("FightYuSeFull"), function ():void {
                    if (checkIsInTime()) {
                        FightManager.startFightWithBoss(NEW_FIGHT_ID[index]);
                        return;
                    }
                    FightManager.startFightWithBoss(FIGHT_ID[index]);
                });
            }
        }]);
    }

    private function canFight():Boolean {
        var _loc3_:int = 0;
        var _loc1_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        var _loc2_:int = int(_loc1_.length);
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            _loc3_ = this.PET_TYPE.indexOf(_loc1_[_loc4_].type);
            if (_loc3_ == -1) {
                AlertManager.showAlert("你不能携带" + PetTypeNameMap.getTypeName(_loc1_[_loc4_].type) + "系的精灵去战斗!");
                return false;
            }
            if (!BitUtil.getBit(this.warPo, _loc3_)) {
                AlertManager.showAlert("你不能携带" + PetTypeNameMap.getTypeName(_loc1_[_loc4_].type) + "系的精灵去战斗!");
                return false;
            }
            _loc4_++;
        }
        return true;
    }

    override public function dispose():void {
        super.dispose();
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.toFight);
    }
}
}
