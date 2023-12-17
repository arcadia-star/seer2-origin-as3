package com.taomee.seer2.app.gameRule.spt
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.gameRule.spt.support.BaseSptSupport;
   import com.taomee.seer2.app.gameRule.spt.support.SPTBufferStatus;
   import com.taomee.seer2.app.gameRule.spt.support.SptBossInfoManager;
   import com.taomee.seer2.app.gameRule.spt.support.SptConfigInfoManager;
   import com.taomee.seer2.app.gameRule.spt.support.SptDialogConfig;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SptShaZhiHeSupport extends BaseSptSupport
   {
      
      private static var _instance:SptShaZhiHeSupport;
       
      
      private const LABEL_NEVERWIN:String = "labelNeverWin";
      
      private const LABEL_UNLEVEL:String = "labelUnLevel";
      
      private const LABEL_WINBEFORE:String = "labelWinBefore";
      
      private var _shazhihe_MC:MovieClip;
      
      public function SptShaZhiHeSupport()
      {
         super();
      }
      
      public static function getInstance() : SptShaZhiHeSupport
      {
         if(!_instance)
         {
            _instance = new SptShaZhiHeSupport();
         }
         return _instance;
      }
      
      override public function init(param1:MapModel) : void
      {
         _sptBossId = SPTBossID.ShaZhiHe;
         _petMaxLevelLimit = SptConfigInfoManager.getSptBossLevel(_sptBossId);
         _sptBufferPosition = SPTBufferStatus.SHAZHIHE_POSITION;
         super.init(param1);
      }
      
      override protected function dealWithMapInit() : void
      {
         var _loc1_:UserInfo = ActorManager.actorInfo;
         var _loc2_:uint = _loc1_.highestPetLevel;
         if(_loc2_ >= _petMaxLevelLimit)
         {
            if(_winHistory)
            {
               this.showSPT(this.LABEL_WINBEFORE);
            }
            else
            {
               this.showSPT(this.LABEL_NEVERWIN);
            }
         }
         else
         {
            this.showSPT(this.LABEL_UNLEVEL);
         }
      }
      
      override protected function fightFailure(param1:LittleEndianByteArray) : void
      {
         var _loc3_:XML = null;
         var _loc4_:DialogDefinition = null;
         var _loc2_:uint = SptBossInfoManager.resolveSpt(_sptBossId,param1);
         if(_loc2_ < SptBossInfoManager.CATCH)
         {
            this.showSPT(this.LABEL_NEVERWIN);
            _loc3_ = new XML(SptDialogConfig.getSptDialog(_sptBossId,1,[SptDialogConfig.getTalkContent(_sptBossId)]));
            _loc4_ = new DialogDefinition(_loc3_);
            DialogPanel.showForCommon(_loc4_);
         }
         else
         {
            this.showSPT(this.LABEL_WINBEFORE);
         }
      }
      
      override protected function fightWin() : void
      {
         if(!_winHistory)
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.SPT,_sptBufferPosition,SPTBufferStatus.FIGHT_WIN);
            _animationPlayer = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation("spt/map_370_fullmovie"));
            _animationPlayer.addEventListener(ProgressiveAnimationPlayer.EVT_END,this.onChairAnimationEnd);
            LayerManager.topLayer.addChild(_animationPlayer);
            SoundManager.enabled = false;
         }
         else
         {
            this.showSPT(this.LABEL_WINBEFORE);
         }
      }
      
      override protected function initSPTNPC() : void
      {
         this._shazhihe_MC = _map.content["sptShaZhiHe"];
         _sptNPC = this._shazhihe_MC["hotZone"];
         _sptNPC.buttonMode = true;
         _sptNPC.useHandCursor = true;
         super.initSPTNPC();
      }
      
      override protected function showSPT(param1:String = null) : void
      {
         if(this._shazhihe_MC)
         {
            this._shazhihe_MC.visible = true;
            if(param1 != null)
            {
               (this._shazhihe_MC as MovieClip).gotoAndPlay(param1);
            }
         }
      }
      
      override protected function hideSPT() : void
      {
         if(this._shazhihe_MC)
         {
            this._shazhihe_MC.visible = false;
         }
      }
      
      override protected function onSPTClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:UserInfo = ActorManager.actorInfo;
         var _loc3_:uint = _loc2_.highestPetLevel;
         if(_loc3_ >= _petMaxLevelLimit)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.SPT,this.checkServerBufferHandler);
         }
         else
         {
            this.unConfigDialloge();
         }
      }
      
      private function checkServerBufferHandler(param1:ServerBuffer) : void
      {
         var beforeSPTWin:Boolean;
         var checkSptBossInfoHandler:Function = null;
         var onClose_1:Function = null;
         var onClose_2:Function = null;
         var startFighter:Function = null;
         var data:XML = null;
         var dialogDefinition:DialogDefinition = null;
         var serverBuffer:ServerBuffer = param1;
         checkSptBossInfoHandler = function(param1:LittleEndianByteArray):void
         {
            var _loc2_:uint = SptBossInfoManager.resolveSpt(SPTBossID.MoGu,param1);
            if(_loc2_ < SptBossInfoManager.WIN)
            {
               unConfigDialloge();
            }
            else
            {
               _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
         };
         onClose_1 = function(param1:String = ""):void
         {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if(param1 == "next")
            {
               _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId,3));
               _loc3_ = new DialogDefinition(_loc2_);
               DialogPanel.showForCommon(_loc3_,onClose_2);
            }
         };
         onClose_2 = function(param1:String = ""):void
         {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if(param1 == "next")
            {
               _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId,4));
               _loc3_ = new DialogDefinition(_loc2_);
               DialogPanel.showForCommon(_loc3_,startFighter);
            }
         };
         startFighter = function(param1:String = ""):void
         {
            if("fight" == param1)
            {
               _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
         };
         serverBuffer.printDataInfo();
         beforeSPTWin = serverBuffer.readDataAtPostion(_sptBufferPosition - 1) == SPTBufferStatus.FIGHT_WIN;
         if(beforeSPTWin)
         {
            _winHistory = serverBuffer.readDataAtPostion(_sptBufferPosition) == SPTBufferStatus.FIGHT_WIN;
            if(_winHistory)
            {
               _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
            else
            {
               data = new XML(SptDialogConfig.getSptDialog(_sptBossId,2));
               dialogDefinition = new DialogDefinition(data);
               DialogPanel.showForCommon(dialogDefinition,onClose_1);
            }
         }
         else
         {
            checkSptBossInfo(checkSptBossInfoHandler);
         }
      }
      
      private function unConfigDialloge() : void
      {
         var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId,5,[_petMaxLevelLimit]));
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function onChairAnimationEnd(param1:Event) : void
      {
         _animationPlayer.removeEventListener(ProgressiveAnimationPlayer.EVT_END,this.onChairAnimationEnd);
         DisplayObjectUtil.removeFromParent(_animationPlayer);
         _animationPlayer = null;
         SoundManager.enabled = true;
         this.showSPT(this.LABEL_WINBEFORE);
         var _loc2_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId,6));
         var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
         DialogPanel.showForCommon(_loc3_);
      }
      
      override public function dispose() : void
      {
         if(this._shazhihe_MC)
         {
            this._shazhihe_MC.gotoAndStop(this._shazhihe_MC.totalFrames);
         }
         this._shazhihe_MC = null;
         super.dispose();
      }
   }
}
