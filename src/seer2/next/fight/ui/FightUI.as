package seer2.next.fight.ui {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.animation.imples.BuffDisabledAnimation;
import com.taomee.seer2.app.arena.controller.FightController;
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.BuffResultInfo;
import com.taomee.seer2.app.arena.data.BuffResultInfoRoundData;
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.arena.data.FighterBuffInfo;
import com.taomee.seer2.app.arena.data.FighterInfo;
import com.taomee.seer2.app.arena.data.FighterTurnResultInfo;
import com.taomee.seer2.app.arena.data.ItemUseResultInfo;
import com.taomee.seer2.app.arena.data.RevenueInfo;
import com.taomee.seer2.app.arena.data.TeamInfo;
import com.taomee.seer2.app.arena.data.TurnResultInfo;
import com.taomee.seer2.app.arena.effect.SkillSound;
import com.taomee.seer2.app.arena.events.OperateEvent;
import com.taomee.seer2.app.arena.processor.ChangeFighterInfo;
import com.taomee.seer2.app.arena.processor.Parser_8;
import com.taomee.seer2.app.arena.processor.Processor_15;
import com.taomee.seer2.app.arena.processor.Processor_9;
import com.taomee.seer2.app.arena.ui.toolbar.ItemPanel;
import com.taomee.seer2.app.arena.util.AngerCorrecter;
import com.taomee.seer2.app.arena.util.FighterActionType;
import com.taomee.seer2.app.arena.util.FightEndReason;
import com.taomee.seer2.app.arena.util.FightMode;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.arena.util.FightWeatherNameMap;
import com.taomee.seer2.app.config.FitConfig;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.PetPressConfig;
import com.taomee.seer2.app.config.SkillSideEffectConfig;
import com.taomee.seer2.app.config.pet.PetFitDefinition;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.constant.PetItemType;
import com.taomee.seer2.app.inventory.item.PetItem;
import com.taomee.seer2.app.manager.FightResultPanelWrapper;
import com.taomee.seer2.app.net.Command;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.ErrorMap;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.ImageLevelManager;
import com.taomee.seer2.core.scene.MapLoader;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Sprite;
import flash.utils.IDataInput;

import seer2.next.entry.DynSwitch;
import seer2.next.fight.auto.AutoFightPanel;

import seer2.next.fight.ui.data.*;
import seer2.next.fight.ui.event.OperateData;
import seer2.next.utils.JsUtils;

public class FightUI extends Sprite {
    public static var enable:Boolean = false;
    public static var disableMoveFrame:Boolean = false;
    public static var clazz:Class;
    {
        UILoader.load(URLUtil.getUISwf("FramePlayer"), LoadType.SWF, function (param1:ContentInfo):void {
            clazz = param1.domain.getDefinition("FramePlayer") as Class;
        });
    }
    private var _arenaScene:ArenaScene;
    private var _rawArenaData:ArenaDataInfo;
    private var _player:*;
    private var _arenaData:ArenaData;
    private var _next:Vector.<Object> = new Vector.<Object>();
    private var _playing:Boolean = false;
    private var _processors:Vector.<Object> = new Vector.<Object>();
    private var _countDown:int;
    private var _operation:Array;
    private var _escapeUid:Array;
    private var _changePet:Array;
    private var _catchPid:uint
    private var _itemId:uint;
    private var _fightRevenue:RevenueInfo;
    private var _fightResult:FightResultInfo;
    private var _uiStyle:int;

    private var _attackAnger:Array = [];
    private var _fitResult:Object;
    private var _fitActor:Object;
    private var _fitChangePending:Boolean = false;

    public function FightUI() {
    }

    public function init(param1:ArenaScene, param2:ArenaDataInfo):void {
        //构造初始帧，并加载UI
        _arenaScene = param1;
        _rawArenaData = param2;
        _arenaData = fromArena(_rawArenaData);
        //非核心功能，先放到ext里面
        FightUIExt.append(_arenaData, _rawArenaData);
        updateWeather(_rawArenaData.fightWeather);
        if (!clazz) {
            throw new Error("clazz is not loaded");
        }
        _player = new clazz;
        if (FightMode.FIGHT_BOSS === _rawArenaData.fightMode || _arenaData.right.master.hp >= 1000) {
            _uiStyle = 1;
        }
        if (is2v2()) {
            _uiStyle = 2;
        }
        _player.updateUiStyle(_uiStyle);
        _player.updateAutoFightStatus(FightUIExt.isDeposit);
        addChild(_player);
        var fightIndex:int = FightManager.currentFightRecord.initData.hasOwnProperty("positionIndex") ? int(FightManager.currentFightRecord.initData.positionIndex) : 0;
        var frame:FrameData = new FrameData;
        frame.start = new StartData();
        var petResUrlVec:Vector.<String> = new Vector.<String>();
        for (var i:int = 0; i < _arenaData.left.pets.length; ++i) {
            petResUrlVec.push(_arenaData.left.pets[i].petSwf);
        }
        for (i = 0; i < _arenaData.right.pets.length; ++i) {
            petResUrlVec.push(_arenaData.right.pets[i].petSwf);
        }
        frame.start.urls = petResUrlVec;
        frame.logs = new Vector.<String>();
        frame.logs.push("<font color=\'#ffffff\'>index:[" + fightIndex + "] side:[" + _rawArenaData.leftTeam.teamInfo.serverSide + "]</font>");
        pushNextFrame(frame);
        pushNextFunc(function ():void {
            Connection.send(CommandSet.FIGHT_RES_READY_1501, fightIndex);
            _player.playFightWaiting();
            addChild(new FightUIExt());
        });

        //收到cmd-2，开始倒计时
        pushProcessor(CommandSet.FIGHT_TURN_START_2, processor2FirstRoundStart);
        pushProcessor(CommandSet.FIGHT_HURT_NOTIFY_3, processor3AttackMove);
        pushProcessor(CommandSet.FIGHT_GET_REVENUE_5, processor5UserRevenue);
        pushProcessor(CommandSet.FIGHT_NEXT_TURN_7, processor7NextRoundStart);
        pushProcessor(CommandSet.FIGHT_CHANGED_NOTIFY_8, processor8ChangePet);
        pushProcessor(CommandSet.FIGHT_BUFF_RESULT_NOTIFY_9, processor9BuffHp);
        pushProcessor(CommandSet.FIGHT_USE_ITEM_NOTIFY_10, processor10UseItem);
        pushProcessor(CommandSet.FIGHT_FEATRUE_RESULT_11, processor11);
        pushProcessor(CommandSet.FIGHT_ESCAPE_NOTIFY_12, processor12UserEscape);
        pushProcessor(CommandSet.FIGHT_NOTIFY_MON_POS_15, processor15PetChange);
        pushProcessor(CommandSet.FIGHT_UPDATE_ANGER_16, processor16AttackBefore);
        pushProcessor(CommandSet.PVP_FIGHT_NOTIFY_MON_POS_17, processor17);
        pushProcessor(CommandSet.FIT_CHANGE_HP_POS_18, processor18PetFit);
        pushProcessor(CommandSet.FIGHT_CHANGE_PET_19, processor19PetMorph);
        pushProcessor(CommandSet.FIGHT_CATCH_PET_1031, processor1031CmdCapsule);
        pushProcessor(CommandSet.FIGHT_CHANGE_FIGHTER_1032, processor1032CmdPet);
        pushProcessor(CommandSet.FIGHT_USE_MEDICINE_1048, processor1048CmdItem);
        pushProcessor(CommandSet.FIGHT_RES_READY_1501, processor1501ResReady);
        pushProcessor(CommandSet.FIGHT_USE_SKILL_1502, processor1502CmdSkill);
        pushProcessor(CommandSet.FIGHT_END_1507, processor1507FightEnd);
        pushProcessor(CommandSet.FIGHT_ESCAPE_1509, processor1509CmdEscape);
        Connection.addErrorHandler(CommandSet.FIGHT_CATCH_PET_1031, processorCmdError);
        Connection.addErrorHandler(CommandSet.FIGHT_CHANGE_FIGHTER_1032, processorCmdError);
        Connection.addErrorHandler(CommandSet.FIGHT_USE_MEDICINE_1048, processorCmdError);
        Connection.addErrorHandler(CommandSet.FIGHT_USE_SKILL_1502, processorCmdError);
        Connection.addErrorHandler(CommandSet.FIGHT_ESCAPE_1509, processorCmdError);
        _player.addEventListener(OperateEvent.OPERATE_END, onOperate);
        _player.addEventListener("sundries", onSundries);
    }

    private function onFightEnd():void {
        if (FightManager.currentFightRecord != null) {
            FightManager.currentFightRecord.endReason = _fightResult.endReason;
            FightManager.currentFightRecord.fightResult = _fightResult.showWinnerSider;
        }

        _player.removeEventListener(OperateEvent.OPERATE_END, onOperate);
        _player.removeEventListener("sundries", onSundries);
        while (_processors.length) {
            var object:Object = _processors.shift();
            Connection.removeCommandListener(object[0], object[1]);
        }
        Connection.removeErrorHandler(CommandSet.FIGHT_CATCH_PET_1031, processorCmdError);
        Connection.removeErrorHandler(CommandSet.FIGHT_CHANGE_FIGHTER_1032, processorCmdError);
        Connection.removeErrorHandler(CommandSet.FIGHT_USE_MEDICINE_1048, processorCmdError);
        Connection.removeErrorHandler(CommandSet.FIGHT_USE_SKILL_1502, processorCmdError);
        Connection.removeErrorHandler(CommandSet.FIGHT_ESCAPE_1509, processorCmdError);
        DisplayObjectUtil.removeFromParent(this);
        FightController.exitFight0(_fightResult, _arenaScene);
    }

    internal function onSundries(event:Object):void {
        var data:Object = event.data;
        var functional:int = data.functional;
        if (functional === 1) {
            _uiStyle = (_uiStyle + 1) % 5;
            _player.updateUiStyle(_uiStyle);
        }
        if (functional === 2) {
            FightUIExt.onDeposit2();
            _player.updateAutoFightStatus(FightUIExt.isDeposit);
        }
        if (functional === 3) {
            ImageLevelManager.showImagePanel();
        }
    }

    internal function onOperate(event:Object):void {
        var data:Object = event.data;
        if (AutoFightPanel.isRunning) {
            AlertManager.showConfirm("【鱼但】帮你战斗中，你要取消吗", function ():void {
                AutoFightPanel.isRunning = false;
            });
            return;
        }
        if (FightUIExt.isDeposit) {
            AlertManager.showAutoCloseAlert("自动战斗中，无法操作", 1);
            return;
        }
        var skill:int = data.skill;
        if (skill > 0) {
            var master:PetData = _arenaData.left.master;
            if (!is2v2() && master.hp <= 0) {
                return;
            }
            var skills:Vector.<SkillData> = _arenaData.left.master.skills;
            for (var i:int = 0; i < skills.length; i++) {
//                if (skills[i].id === skill && skills[i].enable) {
                if (skills[i].id === skill) {//怒气计算不准，这里先放开
                    Connection.send(CommandSet.FIGHT_USE_SKILL_1502, skill);
                }
            }
        }
        var item:int = data.item;
        if (item > 0) {
            var target:uint = _arenaData.left.master.pid;
            if (isRevivalItem(item)) {
                target = uint(data.target);
                if (target === 0 || !canRevivePet(petData(thisUid(), target))) {
                    ServerMessager.addMessage("请选择已倒下且未上场的精灵");
                    return;
                }
            }
            _itemId = item;
            Connection.send(CommandSet.FIGHT_USE_MEDICINE_1048, target, item, 1);
        }
        var pet:uint = data.pet;
        if (pet != 0) {
            var pet0:PetData = petData(thisUid(), pet);
            if (pet0.hp <= 0 || pet0.position > 0) {
                return;
            }
            Connection.send(CommandSet.FIGHT_CHANGE_FIGHTER_1032, pet);
        }
        var capsule:int = data.capsule;
        if (capsule > 0) {
            if (capsule > 200003) {
                var snapshot:int = _countDown;
                AlertManager.showConfirm("FightUI解除了部分限制，无敌不一定能捕获", function ():void {
                    if (snapshot === _countDown) {
                        _itemId = capsule;
                        Connection.send(CommandSet.FIGHT_CATCH_PET_1031, capsule);
                    }
                });
                return;
            }
            _itemId = capsule;
            Connection.send(CommandSet.FIGHT_CATCH_PET_1031, capsule);
        }
        var escape:int = data.escape;
        if (escape > 0) {
            Connection.send(CommandSet.FIGHT_ESCAPE_1509);
        }
    }

    internal function processor2FirstRoundStart(param1:MessageEvent):void {
        _operation = [];
        _arenaData.round = 1;
        pushNextFrame();
        pushNextFunc(playCountDown);
    }

    internal function processor3AttackMove(param1:MessageEvent):void {
        var obj:TurnResultInfo = new TurnResultInfo(param1.message.getRawData());
        var side:int = 1;
        var monster:int;
        var skillId:int;
        var movePet:PetData;
        var actorUid:uint;
        for (var i:int = 0; i < obj.fighterTurnResultInfoVec.length; i++) {
            var turnResult:FighterTurnResultInfo = obj.fighterTurnResultInfoVec[i];
            var pet:PetData = updatePosition(turnResult.userId, turnResult.catchTime, turnResult.position);
            if (turnResult.isAtker) {
                side = teamSide(turnResult.userId);
                monster = rawFighterInfo(turnResult.userId, turnResult.catchTime).resourceId;
                skillId = turnResult.skillId;
                movePet = pet;
                actorUid = turnResult.userId;
            }
            pet.hp = turnResult.hp;
            pet.maxHp = turnResult.maxHp;
            pet.anger = turnResult.anger;
            pet.atk = turnResult.changedAtk;
            pet.def = turnResult.changedDefence;
            pet.spa = turnResult.changedSpecialAtk;
            pet.spd = turnResult.changedSpecialDefence;
            pet.spe = turnResult.changedSpeed;
            pet.buffs = fromBuff(turnResult.buffInfoVec);
        }
        if (skillId <= 0) {
            _attackAnger = [];
            //非攻击，更新下状态就行，无需动画
            pushNextFrame();
            return;
        }
        var bunchId:uint = PetConfig.getPetDefinition(monster).bunchId;
        var skillInfo:SkillInfo = new SkillInfo(skillId);
        var isFusion:Boolean = skillInfo.isIntercourse;
        var target:MoveData = new MoveData();
        target.side = side;
        target.skill = skillInfo.name;
        target.category = isFusion ? "合体" : skillInfo.category;
        target.damage = obj.changedHp;
        target.critical = obj.isCritical ? 1 : 0;
        target.miss = obj.atkTimes === 0 ? 1 : 0;
        target.rate = obj.skillTypeDelationRate;
        target.soundUrl = new SkillSound(bunchId, skillInfo).getSoundUrl();
        target.effectUrl = URLUtil.getSkillEffectSwf(PetConfig.getPetSkillSettingDefinition(skillId).effectId);
        target.hits = FightUIUtil.hitArray(side, monster, target.category);

        var frame:FrameData = new FrameData;
        frame.angerPayment = _attackAnger[side];
        _attackAnger = [];
        if (disableMoveFrame) {
            //简洁模式，只显示伤害，无动画
            frame.event = new EventData;
            frame.event.type = EventData.HP_DECREASE;
            frame.event.side = 3 - target.side;
            frame.event.change = target.damage
            frame.event.delay = 1000;
        } else {
            var defender:TeamData = side === FightSide.LEFT ? _arenaData.right : _arenaData.left;
            target.hitTipIds = [];
            for each (var buff:BuffData in defender.master.buffs) {
                if (BuffDisabledAnimation.BUFF_ID_LIST.indexOf(buff.id) !== -1) {
                    target.hitTipIds.push(buff.id);
                }
            }
            frame.move = target;
            frame.smooth = FrameData.SMOOTH_TRUE;
        }
        frame.logs = new Vector.<String>();
        frame.logs.push("<font color=\'#ffffff\'>[" + _arenaData.round + "]</font><font color=\'#00ffff\'>" + movePet.name + "</font><font color=\'#ffffff\'>使用</font><font color=\'#ffff00\'>" + target.skill + "</font>");
        if (isFusion) {
            _fitActor = {uid: actorUid, pid: movePet.pid, skillId: skillId, continues: false};
        }
        pushNextFrame(frame);
    }

    internal function processor5UserRevenue(param1:MessageEvent):void {
        _fightRevenue = new RevenueInfo(param1.message.getRawData());
    }

    internal function processor7NextRoundStart(param1:MessageEvent):void {
        var buffer:IDataInput = param1.message.getRawData();
        var round:uint = uint(buffer.readUnsignedByte());
        var weather:uint = uint(buffer.readUnsignedByte());

        continueFit();

        //怒气修正，服务端少了下发，只能本地修正
        addPetAnger(_arenaData.left.slave, 15);
        addPetAnger(_arenaData.right.slave, 15);
        AngerCorrecter.angerFix(_arenaData.left.master, _arenaData.right.master,
                rawFighterInfo(_rawArenaData.leftTeam.teamInfo.leaderId, _arenaData.left.master.pid).resourceId,
                rawFighterInfo(_rawArenaData.rightTeam.teamInfo.leaderId, _arenaData.right.master.pid).resourceId
        );
        addPetAnger(_arenaData.left.master, 0);
        addPetAnger(_arenaData.right.master, 0);

        _operation = [];
        _arenaData.round = round;
        updateWeather(weather);
        var frame:FrameData = new FrameData;
        frame.smooth = FrameData.SMOOTH_TRUE;
        pushNextFrame(frame);
        pushNextFunc(function ():void {
            if (!is2v2() && _arenaData.left.master.hp <= 0) {
                _player.showPetPanel();
            }
            playCountDown();
        })
    }

    internal function processor8ChangePet(param1:MessageEvent):void {
        //换场，播放动画
        var buffer:IDataInput = param1.message.getRawData();
        var result:Parser_8 = new Parser_8(buffer);
        var buffInfos:Vector.<FighterBuffInfo> = result.parserFighterBuffInfo(buffer);

        if (_fitActor && result.userId !== _fitActor.uid) {
            var previous:PetData = teamData(result.userId).master;
            if (previous.hp <= 0 && previous.pid !== result.fighterId) {
                continueFit();
            }
        }
        var pet:PetData = updatePosition(result.userId, result.fighterId, 1);
        pet.anger = result.angerValue;
        pet.buffs = fromBuff(buffInfos);
        var frame:FrameData = new FrameData;
        // 合体后的8号包是握手确认，系统精灵直接出现，不播放胶囊出场。
        if (!FitConfig.isPetFit(rawFighterInfo(result.userId, result.fighterId).bunchId)) {
            frame.change = new ChangeData;
            if (thisTeam(result.userId)) {
                frame.change.left = ChangeData.REPLACE;
            } else {
                frame.change.right = ChangeData.REPLACE;
            }
        }
        pushNextFrame(frame);
        if (_changePet && _changePet.length) {
            _changePet = null;
            pushNextFunc(playCountDown);
        }
    }

    internal function processor9BuffHp(param1:MessageEvent):void {
        var resultInfo:BuffResultInfo = Processor_9.parse(param1);
        var side:int = teamSide(resultInfo.userId);
        var pet:PetData = petData(resultInfo.userId, resultInfo.fighterId);
        var buffResults:Vector.<BuffResultInfoRoundData> = resultInfo.buffResultInfoRoundDatas;
        for (var i:int = 0; i < buffResults.length; i++) {
            var buffResult:BuffResultInfoRoundData = buffResults[i];
            var changeHp:int = buffResult.changeHp;
            var frame:FrameData = new FrameData;
            frame.event = new EventData();
            frame.event.side = side;
            frame.event.delay = 30;
            if (changeHp < 0) {
                frame.event.type = EventData.HP_DECREASE;
                frame.event.change = -changeHp;
            } else {
                frame.event.type = EventData.HP_INCREASE;
                frame.event.change = changeHp;
            }
            pet.hp += changeHp;
            if (pet.hp < 0) {
                pet.hp = 0;
            } else if (pet.hp > pet.maxHp) {
                pet.hp = pet.maxHp;
            }
            frame.smooth = FrameData.SMOOTH_TRUE;
            pushNextFrame(frame);
        }

    }

    internal function processor10UseItem(param1:MessageEvent):void {
        //使用道具的通知，早于15
        var obj:ItemUseResultInfo = new ItemUseResultInfo(param1.message.getRawData());
        var pet:PetData = petData(obj.userId, obj.fighterId);
        var hpChange:int = obj.hp - pet.hp;
        var angerChange:int = obj.anger - pet.anger;
        pet.hp = obj.hp;
        pet.maxHp = obj._maxHp;
        pet.anger = obj.anger;
        pet.atk = obj._atkLevel - 6;
        pet.def = obj._defenceLevel - 6;
        pet.spa = obj._specialAtkLevel - 6;
        pet.spd = obj._specialDefenceLevel - 6;
        pet.spe = obj._speedLevel - 6;
        pet.buffs = fromBuff(obj._buffInfoVec);
        var frame:FrameData = new FrameData;
        //只有对战中精灵展示
        if (pet.position > 0) {
            frame.event = new EventData;
            frame.event.type = hpChange > 0 ? EventData.ITEM_HP : EventData.ITEM_ANGER;
            frame.event.side = teamSide(obj.userId);
            frame.event.change = hpChange > 0 ? hpChange : angerChange;
            frame.event.delay = 0;
        }
        pushNextFrame(frame);
    }

    internal function processor11(param1:MessageEvent):void {

    }

    internal function processor12UserEscape(param1:MessageEvent):void {
        _escapeUid = [param1.message.getRawData().readUnsignedInt()];
    }

    internal function processor15PetChange(param1:MessageEvent):void {
        //更新位置信息
        var buffer:IDataInput = param1.message.getRawDataCopy();

        function parse():void {
            var changeInfos:Vector.<ChangeFighterInfo> = Processor_15.parserTeamData(buffer);
            for (var i:int = 0; i < changeInfos.length; i++) {
                var changeFighter:ChangeFighterInfo = changeInfos[i];
                var uid:uint = changeFighter.userId;
                var pid:Number = changeFighter.petCatchTime;
                var anger:uint = changeFighter.angerValue;
                var position:uint = changeFighter.position;
                var master:PetData = teamData(uid).master;
                var slave:PetData = teamData(uid).slave;
                updatePosition(uid, pid, position).anger = anger;
                if (slave && slave.position === 1) {
//                    放动画怪怪的
//                    frame = new FrameData;
//                    frame.event = new EventData;
//                    frame.event.type = EventData.PET_EXCHANGE;
//                    frame.event.side = teamSide(uid);
//                    pushNextFrame(frame);
                    pushNextFrame();
                } else if (!thisTeam(uid) && master !== teamData(uid).master) {
                    var frame:FrameData = new FrameData;
                    frame.change = new ChangeData;
                    frame.change.right = ChangeData.REPLACE;
                    pushNextFrame(frame);
                }
            }
        }

        parse();
        parse();
        pushNextFrame();
    }

    internal function processor16AttackBefore(param1:MessageEvent):void {
        var buffer:IDataInput = param1.message.getRawDataCopy();
        _attackAnger = [];

        function parse():void {
            var uid:uint = uint(buffer.readUnsignedInt());
            var pid:uint = uint(buffer.readUnsignedInt());
            var anger:uint = uint(buffer.readUnsignedInt());
            if (pid === 0) {
                return;
            }
            var slave:PetData = teamData(uid).slave;
            var pet:PetData = updatePosition(uid, pid, 1);
            var payment:Object = {side: teamSide(uid), before: pet.anger, after: anger};
            _attackAnger[payment.side] = payment;
            if (slave && slave.position === 1) {
                var frame:FrameData = new FrameData;
                frame.event = new EventData();
                frame.event.type = EventData.PET_EXCHANGE;
                frame.event.side = teamSide(uid);
                frame.event.delay = 0;
                // 位置交换先播放；耗怒留到3号攻击帧，与攻击同时开始。
                pushNextFrame(frame);
            }
        }

        parse();
        parse();
        for each (var entry:Object in _attackAnger) {
            var team:TeamData = entry.side === FightSide.LEFT ? _arenaData.left : _arenaData.right;
            team.master.anger = entry.after;
        }
    }

    internal function processor17(param1:MessageEvent):void {

    }

    internal function processor18PetFit(param1:MessageEvent):void {
        var buffer:IDataInput = param1.message.getRawDataCopy();
        var i:int;
        var fitPets:Array = [];
        var len:int = uint(buffer.readUnsignedInt());
        for (i = 0; i < len; i++) {
            var uid:int = uint(buffer.readUnsignedInt());
            var pid:uint = buffer.readUnsignedInt();
            var hp:int = uint(buffer.readUnsignedInt());
            fitPets.push([uid, pid, hp])
        }
        var fitSkills:Vector.<SkillInfo> = Vector.<SkillInfo>([]);
        len = uint(buffer.readUnsignedInt());
        for (i = 0; i < len; i++) {
            fitSkills.push(new SkillInfo(buffer.readUnsignedInt()));
        }
        _fitResult = {pets: fitPets, skills: fitSkills};
        completeFit();
    }

    private function continueFit():void {
        if (!_fitActor) return;
        _fitActor.continues = true;
        completeFit();
    }

    private function completeFit():void {
        // 3、18号只确定合体结果；下一回合或对手补位才确认战斗继续。
        if (_fightResult || !_fitResult || !_fitActor || !_fitActor.continues) {
            return;
        }
        var result:Object = _fitResult;
        var actor:Object = _fitActor;
        _fitResult = null;
        _fitActor = null;
        for each (var entry:Array in result.pets) {
            petData(entry[0], entry[1]).hp = entry[2];
        }
        var definition:PetFitDefinition = FitConfig.formSkillIdGetPetFitDefinition(actor.skillId);
        var team:TeamData = teamData(actor.uid);
        var target:PetData;
        for each (var candidate:PetData in team.pets) {
            if (rawFighterInfo(actor.uid, candidate.pid).bunchId === definition.id) {
                target = candidate;
                break;
            }
        }
        if (!target) {
            throw new Error("合体系统精灵不在开场阵容中: " + definition.id);
        }
        updatePosition(actor.uid, target.pid, 1);
        addPetAnger(target, definition.anger);
        if (result.skills.length > 0) {
            target.skills = new <SkillData>[];
            for each (var skill:SkillInfo in result.skills) {
                target.skills.push(fromSkill(skill));
            }
        }
        pushNextFrame();
        if (thisTeam(actor.uid)) {
            // 旧UI UseChangeCMD 的自动握手，不是玩家再选一次换场操作。
            _fitChangePending = true;
            Connection.send(CommandSet.FIGHT_CHANGE_FIGHTER_1032, target.pid);
        }
    }

    internal function processor19PetMorph(param1:MessageEvent):void {
        var buffer:IDataInput = param1.message.getRawData();
        var len:int = int(buffer.readUnsignedInt());
        for (var idx:int = 0; idx < len; idx++) {
            var uid:uint = uint(buffer.readUnsignedInt());
            var typ:int = int(buffer.readUnsignedByte());
            var pid:uint = buffer.readUnsignedInt();
            var morphPid:uint = buffer.readUnsignedInt();
            if (typ !== 0 && typ !== 1) {
                throw new Error("不支持的变身类型: " + typ);
            }
            var pet:PetData = petData(uid, pid);
            var morphPet:PetData = petData(uid, morphPid);
            morphPet.anger = 20;
            if (typ === 0) {
                morphPet.hp = morphPet.maxHp;
            } else {
                morphPet.hp = 0;
            }
            morphPet.position = pet.position;
            pet.hp = 0;
            pet.position = 0;
            var team:TeamData = teamData(uid);
            //神迹变身交换背包位置
            var pos1:int = team.pets.indexOf(pet);
            var pos2:int = team.pets.indexOf(morphPet);
            team.pets[pos1] = morphPet;
            team.pets[pos2] = pet;
            team.init();
            var frame:FrameData = new FrameData();
            frame.change = new ChangeData();
            if (thisTeam(uid)) {
                frame.change.left = ChangeData.MORPH;
            } else {
                frame.change.right = ChangeData.MORPH;
            }
            pushNextFrame(frame);
        }
    }

    internal function processor1031CmdCapsule(param1:MessageEvent):void {
        if (_itemId > 0) {
            ItemManager.reduceItemQuantity(_itemId, 1);
            _itemId = 0;
            _arenaData.left.capsules = fromItem(PetItemType.CAPSULE);
        }
        clearCountDown();
        var _loc2_:IDataInput = param1.message.getRawData();
        var success:uint = uint(_loc2_.readUnsignedInt());
        _catchPid = _loc2_.readUnsignedInt();
        var frame:FrameData = new FrameData;
        frame.event = new EventData;
        frame.event.type = success ? EventData.CATCH_SUCCESS : EventData.CATCH_FAILED;
        pushNextFrame(frame);
        nextPetOperate();
    }

    internal function processor1032CmdPet(param1:MessageEvent):void {
        var buffer:IDataInput = param1.message.getRawData();
        var normal:uint = uint(buffer.readUnsignedByte());
        if (_fitChangePending) {
            _fitChangePending = false;
            return;
        }
        clearCountDown();
        nextPetOperate();
        if (!normal) {
            _changePet = [normal];
        }
    }

    internal function processor1048CmdItem(param1:MessageEvent):void {
        if (_itemId > 0) {
            ItemManager.reduceItemQuantity(_itemId, 1);
            _itemId = 0;
            _arenaData.left.items = fromItem(PetItemType.PHYSICAL_MEDICINE);
        }
        clearCountDown();
        nextPetOperate();
    }

    internal function processor1501ResReady(param1:MessageEvent):void {
        //收到ready，移除等待对手
        _player.clearFgLayer();
    }

    internal function processor1502CmdSkill(param1:MessageEvent):void {
        clearCountDown();
        // 1502只确认选招，不扣怒、不生成状态帧；数值由16号和3号提供。
        nextPetOperate();
    }

    internal function processor1507FightEnd(param1:MessageEvent):void {
        _fightResult = new FightResultInfo(param1.message.getRawDataCopy());
        _fitActor = null;
        _fitResult = null;

        if (_escapeUid && _escapeUid.length) {
            pushNextFunc(function ():void {
                if (thisTeam(_escapeUid[0])) {
                    AlertManager.showAutoCloseAlert("逃跑成功", 1, onFightEnd);
                } else {
                    AlertManager.showAutoCloseAlert("对手已逃跑", 3, onFightEnd);
                }
            });
        } else if (_fightResult.endReason === FightEndReason.TIME_OUT_END) {
            pushNextFunc(function ():void {
                AlertManager.showAutoCloseAlert("战斗超时结束", 3, onFightEnd);
            });
        } else if (_fightResult.endReason === FightEndReason.CATCH_END && _catchPid > 1) {
            //=1是虚拟捕捉 不给精灵
            pushNextFunc(function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("PetCatchPanel"), "正在打开捕捉成功面板...", {
                    "petId": _catchPid,
                    "closeCallback": onFightEnd
                });
            });
        } else if (AutoFightPanel.isRunning) {
            //鱼自动战斗开启时不展示面板
            pushNextFunc(onFightEnd);
        } else {
            var frame:FrameData = new FrameData;
            frame.end = new EndData();
            frame.end.winner = _fightResult.showWinnerSider;
            frame.end.alert = _fightRevenue.fighterRevenueInfoVec.length > 0 ? EndData.HIDDEN : EndData.DEFAULT;
            pushNextFrame(frame);
            pushNextFunc(function ():void {
                if (_fightRevenue.fighterRevenueInfoVec.length > 0) {
                    pushNextFunc(function ():void {
                        new FightResultPanelWrapper(onFightEnd).show(PetInfoManager.getAllBagPetInfo(), _fightRevenue, _fightResult);
                    });
                } else {
                    onFightEnd();
                }
            });
        }
    }

    internal function processor1509CmdEscape(param1:MessageEvent):void {
        clearCountDown();
    }

    internal function processorCmdError(param1:MessageEvent):void {
        if (param1.message.commandId === 1032) {
            _fitChangePending = false;
        }
        ServerMessager.addMessage(ErrorMap.findErrorMessage(param1.message.statusCode));
    }

    private function pushNextFrame(frame:FrameData = null):void {
        if (!frame) {
            frame = new FrameData;
        }
        updateSkillEnable();
        updatePetAlive();
        frame.data = ArenaData.clone(_arenaData);
        setFramePoses(frame);
        updateItemTargets(frame.data.left);
        _next.push({frame: frame});
        playNext();
    }

    private function setFramePoses(frame:FrameData):void {
        var winner:int = frame.end ? frame.end.winner : 0;
        var outgoingSide:int = _fitActor ? teamSide(_fitActor.uid) : 0;
        setTeamPoses(frame.data.left, FightSide.LEFT);
        setTeamPoses(frame.data.right, FightSide.RIGHT);

        function setTeamPoses(team:TeamData, side:int):void {
            for each (var pet:PetData in team.pets) {
                if (side === outgoingSide && pet.pid === uint(_fitActor.pid)) {
                    pet.pose = null;
                } else if (side === winner) {
                    pet.pose = FighterActionType.WIN;
                } else if (pet.hp <= 0) {
                    pet.pose = FighterActionType.DEAD;
                } else if (pet.hp < pet.maxHp * 0.2) {
                    pet.pose = FighterActionType.ABOUT_TO_DIE;
                } else {
                    pet.pose = FighterActionType.IDLE;
                }
            }
        }
    }

    private function pushNextFunc(func:Function):void {
        _next.push({func: func});
        playNext();
    }

    private function playNext():void {
        if (_playing) {
            return;
        }
        if (!_next.length) {
            return;
        }
        var next0:Object = _next.shift();
        if (next0.func) {
            next0.func();
            return;
        }
        _playing = true;
        playFrame(next0.frame, function ():void {
            _playing = false;
            playNext();
        });
    }

    private function playFrame(frame:FrameData, cb:Function):void {
        var _frame:Object = JSON.parse(JSON.stringify(frame));
        JsUtils.call("FightUI_playFrameJson", _frame);
        _player.playFrameJson(_frame, cb);
    }

    private function autoOperateFish():void {
        FightUIExt.fish(_arenaData);
    }

    private function autoOperate():void {
        var pet:PetData = _arenaData.left.master;
        if (pet.hp > 0) {
            var skill:int = 0;
            var skills:Vector.<SkillData> = pet.skills;
            for (var i:int = 0; i < skills.length; i++) {
                if (skills[i].enable) {
                    skill = skills[i].id;
                    break;
                }
            }
            if (DynSwitch.autobsMode) {
                for (i = 0; i < skills.length; i++) {
                    if (skills[i].enable && skills[i].category === '必杀') {
                        skill = skills[i].id;
                        break;
                    }
                }
            }
            Connection.send(CommandSet.FIGHT_USE_SKILL_1502, skill);
        } else {
            var pid:uint = 0;
            var pets:Vector.<PetData> = _arenaData.left.pets;
            for (var j:int = 0; j < pets.length; j++) {
                if (pets[j].hp > 0) {
                    pid = pets[j].pid;
                    break;
                }
            }
            if (pid != 0) {
                Connection.send(CommandSet.FIGHT_CHANGE_FIGHTER_1032, pid);
            } else {
                Connection.send(CommandSet.FIGHT_USE_SKILL_1502, 0);
            }
        }
    }

    private function playCountDown():void {
        _countDown++;
        if (AutoFightPanel.isRunning) {
            autoOperateFish();
            return;
        }
        if (FightUIExt.isDeposit) {
            autoOperate();
            return;
        }
        var snapshot:int = _countDown;
        FightUIExt.callbackWhenDepositBtn = function ():void {
            FightUIExt.callbackWhenDepositBtn = null;
            if (snapshot === _countDown) {
                autoOperate();
            }
        }
        _player.playCountDown(function ():void {
            if (snapshot === _countDown) {
                autoOperate();
            }
        });
    }

    private function clearCountDown():void {
        _countDown++;
        _player.clearFgLayer();
    }

    private function nextPetOperate():void {
        _operation.push(1);
        var slave:PetData = _arenaData.left.slave;
        if (_operation.length === 1 && slave) {
//          if (slave.hp > 0) {
            //还能嗑药回血
            var uid:int = thisUid();
            updatePosition(uid, slave.pid, 1);
            pushNextFrame();
            playCountDown();
//          } else {
//              Connection.send(CommandSet.FIGHT_USE_SKILL_1502, 0);
//          }
        }
    }

    private function updateSkillEnable():void {
        var pets:Vector.<PetData> = _arenaData.left.pets;
        for (var i:int = 0; i < pets.length; i++) {
            var pet:PetData = pets[i];
            for (var j:int = 0; j < pet.skills.length; j++) {
                pet.skills[j].enable = pet.hp > 0 ? (pet.anger >= pet.skills[j].anger) : false;
            }
        }
    }

    private function updatePetAlive():void {
        function update(thisTeam:TeamData, oppoTeam:TeamData):void {
            var pets:Vector.<PetData>;
            var pet:PetData;
            var otherMaster:PetData;
            pets = thisTeam.pets;
            otherMaster = oppoTeam.master;
            for (var i:int = 0; i < pets.length; i++) {
                pet = pets[i];
                pet.alive = pet.hp > 0 ? 1 : 0;
                pet.rate = 100 * PetPressConfig.getPressNumber(pet.ext.typeId, otherMaster.ext.typeId);
                if (pet.position > 0 && pet.ext) {
                    pet.ext.showIcon = 1;
                }
            }
        }

        update(_arenaData.left, _arenaData.right);
        update(_arenaData.right, _arenaData.left);
    }

    private function addPetAnger(pet:PetData, anger:int):void {
        if (pet) {
            pet.anger += anger;
            if (pet.anger < 0) {
                pet.anger = 0;
            }
            if (pet.anger > 100) {
                pet.anger = 100;
            }
        }
    }

    private function updateWeather(weather:int):void {
        if (weather > 0) {
            _arenaData.weatherIcon = "internal://UI_WeatherIcon" + weather;
            _arenaData.weatherTips = FightWeatherNameMap.getWeatherNameByCode(weather);
        } else {
            _arenaData.weatherIcon = "";
            _arenaData.weatherTips = "";
        }
    }

    private function updatePosition(uid:int, pid:uint, position:int):PetData {
        var team:TeamData = teamData(uid);
        var pet:PetData = petData(uid, pid);
        if (position === 1) {
            team.master.position = pet.position;
        } else if (position === 2) {
            team.slave.position = pet.position;
        }
        pet.position = position;
        team.init();
        return pet;
    }

    private function pushProcessor(command:Command, processor:Function):void {
        Connection.addCommandListener(command, processor);
        Connection.releaseCommand(command);
        _processors.push([command, processor]);
    }

    private function is2v2():Boolean {
        return _arenaData.left.slave;
    }

    private function thisUid():int {
        return _rawArenaData.leftTeam.teamInfo.leaderId;
    }

    private function thisTeam(uid:int):Boolean {
        return thisUid() === uid;
    }

    private function teamSide(uid:int):int {
        if (thisTeam(uid)) {
            return FightSide.LEFT;
        } else {
            return FightSide.RIGHT;
        }
    }

    private function teamData(uid:int):TeamData {
        var team:TeamData;
        if (thisTeam(uid)) {
            team = _arenaData.left;
        } else {
            team = _arenaData.right;
        }
        return team;
    }

    private function petData(uid:int, pid:uint):PetData {
        var team:TeamData = teamData(uid);
        for (var i:int = 0; i < team.pets.length; i++) {
            if (team.pets[i].pid === pid) {
                return team.pets[i];
            }
        }
        throw new Error("invalid");
    }

    private function rawFighterInfo(userId:uint, catchTime:uint):FighterInfo {
        return _rawArenaData.fighterInfo(userId, catchTime);
    }

    private static function fromArena(arenaData:ArenaDataInfo):ArenaData {
        var arena:ArenaData = new ArenaData();
        arena.left = fromTeam(arenaData.leftTeam.teamInfo, 1);
        arena.right = fromTeam(arenaData.rightTeam.teamInfo, 2);
        arena.left.items = fromItem(PetItemType.PHYSICAL_MEDICINE);
        arena.left.capsules = fromItem(PetItemType.CAPSULE);
        arena.round = 0;
        arena.mapSwf = MapLoader.lastMapUrl;
        var soundSetting:Array = SoundManager.parseSoundSetting(SoundManager.getCurrentMapSoundSetting());
        if (soundSetting.length > 0) {
            arena.mapSound = soundSetting[0].url;
        }
        return arena;
    }

    private static function fromTeam(team:TeamInfo, side:int):TeamData {
        var pets:Vector.<PetData> = new Vector.<PetData>();
        var fighters:Vector.<FighterInfo> = team.fightUserInfoVec[0].fighterInfoVec;
        for (var i:int = 0; i < fighters.length; i++) {
            pets.push(fromPet(fighters[i], side))
        }
        fighters = team.fightUserInfoVec[0].changeFighterInfoVec;
        for (i = 0; i < fighters.length; i++) {
            pets.push(fromPet(fighters[i], side))
        }
        var target:TeamData = new TeamData();
        target.pets = pets;
        target.items = new <ItemData>[];
        target.capsules = new <ItemData>[];
        target.init();
        return target;
    }

    private static function fromPet(obj:FighterInfo, side:int):PetData {
        var target:PetData = new PetData;
        target.pid = obj.catchTime;
        target.petIcon = URLUtil.getPetIcon(obj.resourceId);
        target.petSwf = URLUtil.getPetFightSwf(FightUIUtil.skinnedMonster(side, obj.resourceId));
        target.petSound = URLUtil.getPetSound(obj.resourceId);
        target.name = obj.name;
        target.level = obj.level;
        target.typeIcon = "internal://UI_PetTypeIcon_" + obj.typeId;
        target.position = obj.position;
        target.alive = 1;//先设置成1
        target.anger = obj.fightAnger;
        target.maxAnger = obj.maxAnger;
        target.hp = obj.hp;
        target.maxHp = obj.maxHp;
        target.rate = 100;
        target.atk = 0;
        target.def = 0;
        target.spa = 0;
        target.spd = 0;
        target.spe = 0;
        target.skills = new <SkillData>[];
        for (var j:int = 0; j < obj.skillInfoVec.length; j++) {
            target.skills.push(fromSkill(obj.skillInfoVec[j]));
        }
        target.buffs = new <BuffData>[];
        target.items = new <ItemData>[];
        var extData:PetExtData = new PetExtData;
        extData.monster = obj.resourceId;
        extData.showIcon = 0;
        extData.typeId = obj.typeId;
        target.ext = extData;
        return target;
    }

    private static function fromSkill(obj:SkillInfo):SkillData {
        var target:SkillData = new SkillData();
        target.id = obj.id;
        target.name = obj.name;
        target.power = obj.power;
        target.anger = obj.anger;
        target.category = obj.category;
        target.typeIcon = "internal://UI_PetTypeIcon_" + obj.typeId;
        target.tips = obj.description;
        target.enable = false;
        return target;
    }

    private static function isRevivalItem(itemId:int):Boolean {
        return ItemConfig.getPetDefinition(itemId).type === PetItemType.RESURRECTION;
    }

    private static function canRevivePet(pet:PetData):Boolean {
        return pet.position === 0 && pet.hp <= 0;
    }

    private static function updateItemTargets(team:TeamData):void {
        var targets:Vector.<uint> = new <uint>[];
        for each (var pet:PetData in team.pets) {
            if (canRevivePet(pet)) targets.push(pet.pid);
        }
        for each (var item:ItemData in team.items) {
            if (isRevivalItem(item.id)) item.targetPids = targets;
        }
    }

    private static function fromItem(typ:int):Vector.<ItemData> {
        var items:Vector.<ItemData> = new <ItemData>[];
        var petItems:Vector.<PetItem> = ItemPanel.filterItemsAllFight(typ);
        for (var i:int = 0; i < petItems.length; i++) {
            var obj:PetItem = petItems[i];
            var target:ItemData = new ItemData;
            target.id = obj.referenceId;
            target.name = obj.name;
            target.count = obj.quantity;
            target.icon = ItemConfig.getItemIconUrl(obj.referenceId);
            target.tips = obj.tip;
            items.push(target);
        }
        return items;
    }

    private static function fromBuff(buffInfoVec:Vector.<FighterBuffInfo>):Vector.<BuffData> {
        var buffs:Vector.<BuffData> = new <BuffData>[];
        for (var k:int = 0; k < buffInfoVec.length; k++) {
            var buff:FighterBuffInfo = buffInfoVec[k];
            if (buff.round <= 0) {
                continue;
            }
            var buffData:BuffData = new BuffData();
            buffData.id = buff.buffId;
            buffData.name = buff.buffId + "-" + SkillSideEffectConfig.getName(buff.buffId);
            buffData.icon = URLUtil.getSkillSideEffectIcon(buff.buffId);
            buffData.tips = buff.tip;
            buffData.count = buff.dummy2;
            buffs.push(buffData);
        }
        return buffs;
    }
}
}
