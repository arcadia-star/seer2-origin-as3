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
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SptTeMiTiSupport extends BaseSptSupport
   {
      
      private static var _instance:SptTeMiTiSupport;
       
      
      private const LABEL_NEVERWIN:String = "normal";
      
      private const LABEL_UNLEVEL:String = "normal";
      
      private const LABEL_WINBEFORE:String = "normal";
      
      private var _temiti_MC:MovieClip;
      
      public function SptTeMiTiSupport()
      {
         super();
      }
      
      public static function getInstance() : SptTeMiTiSupport
      {
         if(!_instance)
         {
            _instance = new SptTeMiTiSupport();
         }
         return _instance;
      }
      
      override public function init(param1:MapModel) : void
      {
         _sptBossId = SPTBossID.TeMiTi;
         _petMaxLevelLimit = SptConfigInfoManager.getSptBossLevel(_sptBossId);
         _sptBufferPosition = SPTBufferStatus.TEMITI_POSITION;
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
            _loc3_ = new XML(SptDialogConfig.getSptDialog(_sptBossId,6,[SptDialogConfig.getTalkContent(_sptBossId)]));
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
            _animationPlayer = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation("spt/map_1220_fullmovie"));
            _animationPlayer.addEventListener(ProgressiveAnimationPlayer.EVT_END,this.onChairAnimationEnd);
            LayerManager.topLayer.addChild(_animationPlayer);
         }
         else
         {
            this.showSPT(this.LABEL_WINBEFORE);
         }
      }
      
      override protected function initSPTNPC() : void
      {
         _sptNPC = _map.content["sptTeMiTi"];
         _sptNPC.buttonMode = true;
         _sptNPC.useHandCursor = true;
         super.initSPTNPC();
      }
      
      override protected function showSPT(param1:String = null) : void
      {
         if(this._temiti_MC)
         {
            this._temiti_MC.visible = true;
            if(param1 != null)
            {
               (this._temiti_MC as MovieClip).gotoAndPlay(param1);
            }
         }
      }
      
      override protected function hideSPT() : void
      {
         if(this._temiti_MC)
         {
            this._temiti_MC.visible = false;
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
         var data:XML = null;
         var dialogDefinition:DialogDefinition = null;
         var serverBuffer:ServerBuffer = param1;
         checkSptBossInfoHandler = function(param1:LittleEndianByteArray):void
         {
            var _loc2_:uint = SptBossInfoManager.resolveSpt(SPTBossID.Kadosh,param1);
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
            if(param1 == "prepareFight")
            {
               _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId,3));
               _loc3_ = new DialogDefinition(_loc2_);
               DialogPanel.showForCommon(_loc3_,onClose_2);
            }
         };
         onClose_2 = function(param1:String = ""):void
         {
            if(param1 == "fight")
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
         var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId,1,[_petMaxLevelLimit]));
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function onChairAnimationEnd(param1:Event) : void
      {
         var data:XML;
         var dialogDefinition:DialogDefinition;
         var onClose_3:Function = null;
         var evt:Event = param1;
         onClose_3 = function(param1:String = ""):void
         {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if(param1 == "next2")
            {
               _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId,5));
               _loc3_ = new DialogDefinition(_loc2_);
               DialogPanel.showForCommon(_loc3_,onClose_3);
            }
         };
         _animationPlayer.removeEventListener(ProgressiveAnimationPlayer.EVT_END,this.onChairAnimationEnd);
         DisplayObjectUtil.removeFromParent(_animationPlayer);
         _animationPlayer = null;
         this.showSPT(this.LABEL_WINBEFORE);
         data = new XML(SptDialogConfig.getSptDialog(_sptBossId,4));
         dialogDefinition = new DialogDefinition(data);
         DialogPanel.showForCommon(dialogDefinition,onClose_3);
      }
      
      override public function dispose() : void
      {
         if(this._temiti_MC)
         {
            this._temiti_MC.gotoAndStop(this._temiti_MC.totalFrames);
         }
         this._temiti_MC = null;
         super.dispose();
      }
   }
}
