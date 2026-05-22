package seer2.next.fight.ui {
import com.taomee.seer2.app.actor.UserInfoManager;
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterInfo;
import com.taomee.seer2.app.arena.data.TeamInfo;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.util.FightPostion;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.info.PetDictionaryInfo;
import com.taomee.seer2.app.config.pet.PetDefinition;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import seer2.next.fight.auto.AutoFightPanel;
import seer2.next.fight.ui.data.ArenaData;
import seer2.next.fight.ui.data.PetData;
import seer2.next.fight.ui.data.PetExtData;

public class FightUIExt extends Sprite {
    public static var isDeposit:Boolean = false;
    public static var callbackWhenDepositBtn:Function;

    private var _depositTxtMc:MovieClip;

    private var _deposite:MovieClip;

    public function FightUIExt() {
        createDepositBtn();
    }

    public function createDepositBtn():void {
        this._deposite = FightUIManager.getMovieClip("New_UI_DepositBtn");
        this._deposite.y = 435 - 50;
        this._deposite.x = 1140;
        this._deposite.buttonMode = true;
        isDeposit = false;
        this._deposite.addEventListener(MouseEvent.CLICK, this.onDeposite);
        addChild(this._deposite);
        this._deposite.gotoAndStop(1);
        this._depositTxtMc = FightUIManager.getMovieClip("New_UI_DepositTxt");
        this._depositTxtMc.x = 490;
        this._depositTxtMc.y = 125;
        this._depositTxtMc.visible = false;
        addChild(this._depositTxtMc);
    }

    private function onDeposite(param1:MouseEvent):void {
        if ((param1.currentTarget as MovieClip).currentFrame <= 2) {
            isDeposit = true;
            (param1.currentTarget as MovieClip).gotoAndStop(3);
            this._depositTxtMc.visible = true;
            if (FightUIExt.callbackWhenDepositBtn) {
                FightUIExt.callbackWhenDepositBtn();
            }
        } else if ((param1.currentTarget as MovieClip).currentFrame == 3) {
            isDeposit = false;
            (param1.currentTarget as MovieClip).gotoAndStop(1);
            this._depositTxtMc.visible = false;
        }
        SoundEffects.playSoundMouseClick(0.35);
    }

    public static function fish(_arenaData:ArenaData):void {
        var op:int = AutoFightPanel.instance().getOperation();
        if (op < 6) {
            skillOp(op);
        } else if (op == 6) {
            runOp();
        } else if (op == 7) {
            cure();
        } else if (op == 8) {
            capture();
        } else if (op > 20 && op < 30) {
            angerSupplement(op);
        } else if (op > 10 && op < 20) {
            changeOp(op);
        }

        function skillOp(skillIndex:int):void {
            if (_arenaData.left.master.hp > 0) {
                var skillId:int = _arenaData.left.master.skills[skillIndex].id;
                Connection.send(CommandSet.FIGHT_USE_SKILL_1502, skillId);
                return;
            }
            var pid:int = 0;
            var pets:Vector.<PetData> = _arenaData.left.pets;
            for (var j:int = 0; j < pets.length; j++) {
                if (pets[j].hp > 0) {
                    pid = pets[j].pid;
                    break;
                }
            }
            if (pid != 0) {
                Connection.send(CommandSet.FIGHT_CHANGE_FIGHTER_1032, pid);
            }
        }

        function runOp():void {
            Connection.send(CommandSet.FIGHT_ESCAPE_1509);
        }

        function cure():void {
            Connection.send(CommandSet.FIGHT_USE_MEDICINE_1048, _arenaData.left.master.pid, 200019, 1);
        }

        function capture():void {
            Connection.send(CommandSet.FIGHT_CATCH_PET_1031, 200003);
        }

        function angerSupplement(param:uint):void {
            Connection.send(CommandSet.FIGHT_USE_MEDICINE_1048, _arenaData.left.master.pid, 200000 + param, 1);
        }

        function changeOp(petIndex:int):void {
            var o:PetData = _arenaData.left.pets[petIndex - 11];
            if (o.position != FightPostion.INACTIVE) {
                skillOp(0);
            } else if (o.hp > 0) {
                Connection.send(CommandSet.FIGHT_CHANGE_FIGHTER_1032, o.pid);
            } else if (o.hp == 0) {
                Connection.send(CommandSet.FIGHT_USE_MEDICINE_1048, o.pid, 200064, 1);
            }
        }
    }

    public static function append(arenaData:ArenaData, _rawArenaData:ArenaDataInfo):void {
        var pets:Vector.<PetData> = arenaData.left.pets;
        var leftUid:int = _rawArenaData.leftTeam.teamInfo.leaderId;
        for (var i:int = 0; i < pets.length; i++) {
            var pet:PetData = pets[i];
            var rawFighter:FighterInfo = _rawArenaData.fighterInfo(leftUid, pet.pid);
            if (!rawFighter) {
                continue;
            }
            var petDefinition:PetDefinition = PetConfig.getPetDefinition(rawFighter.resourceId);
            var petDefinitionInfo:PetDictionaryInfo = PetConfig.getPetDefinitionInfo(rawFighter.resourceId);
            var rawPet:PetInfo = PetInfoManager.getPetInfoFromAllBag(pet.pid);

            var petExtData:PetExtData = pet.ext;
            petExtData.sex = rawPet ? rawPet.sex : 0;
            var featureId:int = rawPet ? rawPet.featureId : 0;
            if (featureId > 0) {
                petExtData.featureTips = rawPet.featureDescription;
            }
            var emblemId:int = rawPet ? rawPet.emblemId : 0;
            if (emblemId > 0) {
                petExtData.emblem1 = emblemId;
                petExtData.emblem1Tips = ItemConfig.getEmblemDefinition(emblemId).tip;
            } else if (petDefinition && petDefinition.emblemId > 0) {
                petExtData.emblem1Tips = ItemConfig.getEmblemDefinition(petDefinition.emblemId).tip;
            }
            var decorationId:int = rawPet ? rawPet.decorationId : 0;
            if (decorationId > 0) {
                petExtData.emblem2 = decorationId;
                petExtData.emblem2Tips = ItemConfig.getEmblemDefinition(decorationId).tip;
            } else if (petDefinition && petDefinition.emblem2Id > 0) {
                petExtData.emblem2Tips = ItemConfig.getEmblemDefinition(petDefinition.emblem2Id).tip;
            }
            petExtData.fetterTips = petDefinitionInfo ? petDefinitionInfo.fetter : null;
            petExtData.morphTips = petDefinitionInfo ? petDefinitionInfo.changeTip : null;
        }
    }
}
}
