package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   
   public class MapProcessor_80348 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [205163,205174,205162,205165];
      
      private static const DAY_LIST:Array = [1476];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3460]);
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1370]);
      
      private static const NPC_ID_LIST:Vector.<int> = Vector.<int>([831]);
      
      private static const FIGHT_NUM:int = 5;
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605212,605213]);
      
      private static const AWARD_NUM:Vector.<int> = Vector.<int>([500000,1500000,3000000]);
       
      
      private var _par:Parser_1142;
      
      private var _info:DayLimitListInfo;
      
      private var _npc:Mobile;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _swapUI:MovieClip;
      
      private var _bar:MovieClip;
      
      private var _getAwardList:Vector.<SimpleButton>;
      
      private var _getedMarkList:Vector.<MovieClip>;
      
      private var _hurtNum:TextField;
      
      private var _fightNum:TextField;
      
      private var _fightComplete:MovieClip;
      
      public function MapProcessor_80348(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.onActInit();
      }
      
      private function onActInit() : void
      {
         this.hideLobbyMenu();
         this.swapUIInitSet();
         this.initEvent();
         this.update();
      }
      
      private function initEvent() : void
      {
         var _loc1_:SimpleButton = null;
         for each(_loc1_ in this._getAwardList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onGetAward);
         }
      }
      
      private function onGetAward(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         var index:int = this._getAwardList.indexOf(evt.currentTarget);
         SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            updateBar();
         },null,new SpecialInfo(1,index));
      }
      
      private function setFuncDisable() : void
      {
         var _loc1_:SimpleButton = null;
         for each(_loc1_ in this._getAwardList)
         {
            _loc1_.mouseEnabled = false;
         }
      }
      
      private function updateData(param1:Function = null) : void
      {
         var func:Function = param1;
         this.setFuncDisable();
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               var _loc2_:SimpleButton = null;
               _par = par;
               _info = param1;
               for each(_loc2_ in _getAwardList)
               {
                  _loc2_.mouseEnabled = true;
               }
               if(func != null)
               {
                  func();
               }
            });
         });
      }
      
      private function updateBar() : void
      {
         this.updateData(this.getBarStateHandle);
      }
      
      private function update() : void
      {
         this.updateData(function():void
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.FIGHT_KING_SUPER_PROCESS,function(param1:ServerBuffer):void
            {
               var server:ServerBuffer = param1;
               var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
               if(!_isPlay)
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.FIGHT_KING_SUPER_PROCESS,1,1);
                  MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("FightKingSuperProcessAct1"),function():void
                  {
                     addNpc();
                     _npc.addEventListener(MouseEvent.CLICK,onNpcClick);
                  },false,true,2,true);
               }
               else
               {
                  addNpc();
                  _npc.addEventListener(MouseEvent.CLICK,onNpcClick);
               }
               getBarStateHandle();
               if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[0])
               {
                  if(_par.infoVec[2] >= AWARD_NUM[2])
                  {
                     SceneManager.changeScene(SceneType.COPY,80349);
                  }
                  else
                  {
                     NpcDialog.show(831,"斗神",[[0,"距离300万伤害还差" + (AWARD_NUM[2] - _par.infoVec[2]) + "，请再接再厉！斗神等着你哦~"]],["确定","一键通关"],[null,function():void
                     {
                        ShopManager.buyItemForId(MI_ID_LIST[1],function():void
                        {
                           SceneManager.changeScene(SceneType.COPY,80349);
                        });
                     }]);
                  }
               }
            });
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function addNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 82;
            this._npc.height = 115;
            this._npc.setPostion(new Point(610,400));
            this._npc.resourceUrl = URLUtil.getNpcSwf(NPC_ID_LIST[0]);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "斗神";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            this.showMouseHintAtMonster(this._npc);
            MobileManager.addMobile(this._npc,MobileType.NPC);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         var canFightNum:int = ActsHelperUtil.getCanNum(this._info.getCount(DAY_LIST[0]),this._par.infoVec[0],FIGHT_NUM);
         if(canFightNum > 0)
         {
            NpcDialog.show(831,"斗神",[[0,"即将开始与斗神的挑战，今天还剩余" + canFightNum + "次挑战机会，每次最多造成斗神25万伤害。"]],["开始挑战","准备一下"],[function():void
            {
               FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
            }]);
         }
         else
         {
            NpcDialog.show(831,"斗神",[[0,"今天的挑战次数已经用尽，是否花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻立即挑战？"]],["开始挑战","准备一下"],[function():void
            {
               ShopManager.buyItemForId(MI_ID_LIST[0],function():void
               {
                  updateData(function():void
                  {
                     FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
                  });
               });
            }]);
         }
      }
      
      private function removeNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            this._npc = null;
         }
      }
      
      private function showMouseHintAtMonster(param1:Sprite) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -param1.height - 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
         param1.addChild(this._mouseHint);
      }
      
      private function swapUIInitSet() : void
      {
         this._swapUI = _map.front["swapUI"];
         this._bar = this._swapUI["bar"] as MovieClip;
         this._getAwardList = new Vector.<SimpleButton>();
         this._getedMarkList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 2)
         {
            this._getAwardList.push(this._swapUI["getAward" + _loc1_]);
            this._getedMarkList.push(this._swapUI["getedMark" + _loc1_]);
            _loc1_++;
         }
         this._hurtNum = this._swapUI["hurtNum"];
         this._fightNum = this._swapUI["fightNum"];
         this._fightComplete = this._swapUI["fightComplete"];
      }
      
      private function getBarStateHandle() : void
      {
         this._bar.scaleY = this._par.infoVec[2] / AWARD_NUM[2] > 1 ? 1 : this._par.infoVec[2] / AWARD_NUM[2];
         var _loc1_:int = 0;
         while(_loc1_ < AWARD_NUM.length)
         {
            if(this._par.infoVec[2] >= AWARD_NUM[_loc1_])
            {
               if(_loc1_ <= 1)
               {
                  if(BitUtil.getBit(this._par.infoVec[1],_loc1_))
                  {
                     this._getedMarkList[_loc1_].visible = true;
                     DisplayObjectUtil.disableButton(this._getAwardList[_loc1_]);
                  }
                  else
                  {
                     this._getedMarkList[_loc1_].visible = false;
                     DisplayObjectUtil.enableButton(this._getAwardList[_loc1_]);
                  }
               }
               else
               {
                  this._fightComplete.visible = true;
               }
            }
            else if(_loc1_ <= 1)
            {
               this._getedMarkList[_loc1_].visible = false;
               DisplayObjectUtil.disableButton(this._getAwardList[_loc1_]);
            }
            else
            {
               this._fightComplete.visible = false;
            }
            _loc1_++;
         }
         this._hurtNum.text = this._par.infoVec[2].toString();
         this._fightNum.text = ActsHelperUtil.getCanNum(this._info.getCount(DAY_LIST[0]),this._par.infoVec[0],FIGHT_NUM).toString();
      }
      
      private function onActDispose() : void
      {
         this.removeNpc();
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
