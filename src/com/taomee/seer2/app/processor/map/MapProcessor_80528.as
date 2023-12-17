package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.utils.FightHelpUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   
   public class MapProcessor_80528 extends MapProcessor
   {
      
      private static const NpcIds:Vector.<int> = Vector.<int>([477,499,514]);
      
      private static const FightIds:Vector.<int> = Vector.<int>([1816,1817,1818,1819]);
      
      private static const Positions:Vector.<Point> = Vector.<Point>([new Point(363,193),new Point(959,372),new Point(825,490)]);
       
      
      private var _petBagBtn:SimpleButton;
      
      private var _reBloodBtn:SimpleButton;
      
      private var _fightNum:TextField;
      
      private var _mobiles:Vector.<Mobile>;
      
      public function MapProcessor_80528(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._petBagBtn = _map.front["petBagBtn"];
         this._reBloodBtn = _map.front["reBloodBtn"];
         this.hideLobbyMenu();
         this._mobiles = new Vector.<Mobile>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._mobiles.push(new Mobile());
            _loc1_++;
         }
         new FightHelpUtil(this._petBagBtn,this._reBloodBtn);
         FightManager.addEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
         this.story();
         this.checkMobile();
      }
      
      private function onCompleteMap(param1:SceneEvent) : void
      {
         if(SceneManager.active.mapID == 70)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onCompleteMap);
         }
      }
      
      private function story() : void
      {
         NpcDialog.show(511,"影灵的幻视",[[0,"星际使者，别来无恙。距离那次大战已然过去四年的时光……吾所看到的，是汝对于希望和真相的渴求。然不知汝有没有足以触碰到真相的实力呢呢？且让吾来试它一试！"]],[" 什么？你又要开启两亿外挂模式了么？"],[function():void
         {
            NpcDialog.show(511,"影灵的幻视",[[0,"嚯……吾已然没有当时对目标的执念。还记得否？吾在面对那只有王之气息的精灵时，自身的变化吗？"]],[" 凯伊么……那时的影灵兽突然从两亿血变成区区100了...."],[function():void
            {
               NpcDialog.show(511,"影灵的幻视",[[0,"然也，直觉告诉吾，这精灵的力量在日后的计划中确有不俗的作用，故此，吾将大多力量转化到无限的触手中，释放暗影之力将其扫描了下来。虽然100%重现不太可能，但若是给予汝一些帮助也是足够了。"]],[" 你也是……很厉害的家伙呢，无论是实力上来说，还是谋略上"],[function():void
               {
                  NpcDialog.show(511,"影灵的幻视",[[0,"那么，去品尝这投射出来的暗影吧。吾在这里静静的恭候汝的挑战"]],["你等着，我会让你看到我自己的，【希望之光】！"],[function():void
                  {
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function checkMobile() : void
      {
         var i:int = 0;
         i = 0;
         while(i < 3)
         {
            this._mobiles[i].resourceUrl = URLUtil.getNpcSwf(NpcIds[i]);
            this._mobiles[i].buttonMode = true;
            this._mobiles[i].addEventListener(MouseEvent.CLICK,this.toFight);
            this._mobiles[i].setPostion(Positions[i]);
            this._mobiles[i].height = 100;
            MobileManager.addMobile(this._mobiles[i],MobileType.NPC);
            i++;
         }
         DayLimitListManager.getDaylimitList([1935],function callback(param1:DayLimitListInfo):void
         {
            var _loc2_:uint = param1.getCount(1935);
            _mobiles[0].visible = BitUtil.getBit(_loc2_,8) <= 0;
            _mobiles[1].visible = BitUtil.getBit(_loc2_,9) <= 0;
         });
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var index:int = 0;
         var e:MouseEvent = param1;
         index = this._mobiles.indexOf(e.currentTarget as Mobile);
         if(this.isCanFight())
         {
            switch(index)
            {
               case 0:
                  NpcDialog.show(477,"雷伊",[[0,"朦胧的紫气环绕着雷伊，并不像真正的雷伊一样闪烁着雷电与金光，双眼也不太有神"]],[" 进入挑战 ","再等一下"],[function():void
                  {
                     FightManager.startFightWithWild(FightIds[index]);
                  }]);
                  break;
               case 1:
                  NpcDialog.show(499,"凯萨",[[0,"（朦胧的紫气环绕着凯萨，并不像真正的凯萨一样会辐射热量与红外线，像冥火一般幽静）"]],["进入挑战 ","再等一下"],[function():void
                  {
                     FightManager.startFightWithWild(FightIds[index]);
                  }]);
                  break;
               case 2:
                  DayLimitListManager.getDaylimitList([1935],function callback(param1:DayLimitListInfo):void
                  {
                     var info:DayLimitListInfo = param1;
                     var num:uint = info.getCount(1935);
                     if(Boolean(BitUtil.getBit(num,8)) && Boolean(BitUtil.getBit(num,9)))
                     {
                        index = 3;
                     }
                     if(index == 2)
                     {
                        NpcDialog.show(511,"影灵的幻视",[[0,"嚯……不想借助曾经的力量么？有如此自信，那吾也必当全力以赴。"]],["来吧！！！","啊……没，点错了再等等"],[function():void
                        {
                           FightManager.startFightWithWild(FightIds[index]);
                           FightManager.addEventListener(FightStartEvent.FIGHT_OVER,overHandler);
                        }]);
                     }
                     else
                     {
                        NpcDialog.show(511,"影灵的幻视",[[0,"汝的身上……吾仿佛看到了当年的景象。朦胧的王之气息……精灵王实乃这星球永恒的希望。来吧，将汝全部的力量向吾袭来，让吾见识一下，汝自己的希望之光！"]],["恭敬不如从命！！！","我再准备下"],[function():void
                        {
                           FightManager.startFightWithWild(FightIds[index]);
                        }]);
                     }
                  });
            }
         }
         else
         {
            AlertManager.showAlert("不能携带精灵王系，上古系，圣灵系精灵系别的精灵挑战哦!");
         }
      }
      
      private function overHandler(param1:FightStartEvent) : void
      {
         if(FightManager.getPositionIndex() == FightIds[2] || FightManager.getPositionIndex() == FightIds[3])
         {
            (SceneManager.active as LobbyScene).showToolbar();
            FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
            SceneManager.changeScene(SceneType.LOBBY,70);
         }
      }
      
      private function isCanFight() : Boolean
      {
         var _loc2_:PetInfo = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
         {
            if([19,20,21].indexOf(_loc2_.type) != -1)
            {
               _loc1_ = false;
               break;
            }
         }
         return _loc1_;
      }
      
      private function initFight() : void
      {
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      override public function dispose() : void
      {
      }
   }
}
