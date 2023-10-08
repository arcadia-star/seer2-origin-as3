package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.PayManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80161 extends TitleMapProcessor
   {
      
      private static const FIGHT_INDEX:int = 855;
      
      private static const FOR_LIST:Array = [203877,203887,203895,203901];
      
      private static const DAY_LIST:Array = [1036,1037,1041,1040,1045];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([2555,2562]);
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([603585,500602]);
      
      private static const MAX_TURN:int = 3;
       
      
      private var _use:SimpleButton;
      
      private var _help:SimpleButton;
      
      private var _tip:SimpleButton;
      
      private var _allHurt:TextField;
      
      private var _turnNum:TextField;
      
      private var _addTurn:SimpleButton;
      
      private var _leave:SimpleButton;
      
      private var _npc:Mobile;
      
      private var _par:Parser_1142;
      
      private var _info:DayLimitListInfo;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function MapProcessor_80161(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.yingMoAnShaActInit();
      }
      
      private function yingMoAnShaActInit() : void
      {
         this.initSet();
         this.initEvent();
         this.update();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            ModuleManager.showModule(URLUtil.getAppModule("YingFightResultPanel"),"正在打开面板...",{
               "funcAdd":this.update,
               "funcLeave":this.onLeaveClick
            });
         }
      }
      
      private function initSet() : void
      {
         this.hideLobbyMenu();
         this.addNpc();
         this._use = _map.front["use"];
         this._help = _map.front["help"];
         this._tip = _map.front["tip"];
         this._allHurt = _map.front["allHurt"];
         this._turnNum = _map.front["turnNum"];
         this._addTurn = _map.front["addTurn"];
         this._leave = _map.front["leave"];
      }
      
      private function initEvent() : void
      {
         this._use.addEventListener(MouseEvent.CLICK,this.onUse);
         this._help.addEventListener(MouseEvent.CLICK,this.onHelp);
         this._tip.addEventListener(MouseEvent.CLICK,this.onTip);
         this._addTurn.addEventListener(MouseEvent.CLICK,this.onAddTurn);
         this._leave.addEventListener(MouseEvent.CLICK,this.onLeaveClick);
      }
      
      private function onLeaveClick(param1:MouseEvent = null) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("LeaveTipPanel"),"正在打开面板...",{"funcLeave":this.onLeave});
      }
      
      private function onUse(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._par.infoVec[2] == 0)
         {
            SwapManager.swapItem(SWAP_LIST[1],1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               AlertManager.showAlert("免费伤害药剂领取成功!");
               update();
            });
         }
         else if(this._par.infoVec[2] == 1)
         {
            AlertManager.showAlert("你当前已经领取过免费伤害药剂了！");
         }
         else if(this._par.infoVec[2] == 2)
         {
            ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,function getItem(param1:ItemEvent):void
            {
               var num:int;
               var evt:ItemEvent = param1;
               ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,getItem);
               num = ItemManager.getSpecialItem(MI_ID_LIST[1]) != null ? int(ItemManager.getSpecialItem(MI_ID_LIST[1]).quantity) : 0;
               if(num > 0)
               {
                  AlertManager.showAlert("伤害药剂使用完再来购买吧!");
               }
               else
               {
                  AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[1]) + "星钻购买伤害药剂吗?",function():void
                  {
                     PayManager.buyItem(MI_ID_LIST[1],function():void
                     {
                        update();
                     });
                  });
               }
            });
            ItemManager.requestSpecialItemList();
         }
      }
      
      private function onHelp(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
      }
      
      private function onTip(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("FightHelpPanel"));
      }
      
      private function onAddTurn(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻增加一次挑战吗?",function():void
         {
            PayManager.buyItem(MI_ID_LIST[0],function():void
            {
               update();
            });
         });
      }
      
      private function onLeave() : void
      {
         var oldPar:Parser_1142 = null;
         oldPar = this._par;
         SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var index:int;
               var par:Parser_1142 = param1;
               _par = par;
               index = getChangeIndex(oldPar.infoVec[0],_par.infoVec[0]);
               if(index != -1)
               {
                  MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("yingMoAnSha/YingMoAnSha" + index.toString()),function():void
                  {
                     SceneManager.changeScene(SceneType.LOBBY,70);
                  },false,false,2,false);
               }
               else
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
               }
            });
         });
      }
      
      private function getChangeIndex(param1:int, param2:int) : int
      {
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < 4)
         {
            if(BitUtil.getBit(param1,_loc4_) != BitUtil.getBit(param2,_loc4_))
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function update() : void
      {
         this._npc.mouseEnabled = this._npc.mouseChildren = false;
         this._addTurn.mouseEnabled = this._leave.mouseEnabled = false;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               _allHurt.text = _info.getCount(DAY_LIST[3]).toString();
               _turnNum.text = getCanNum(_info.getCount(DAY_LIST[1]),_info.getCount(DAY_LIST[2]),MAX_TURN).toString();
               _npc.mouseEnabled = _npc.mouseChildren = true;
               _addTurn.mouseEnabled = _leave.mouseEnabled = true;
            });
         });
      }
      
      private function getCanNum(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param1 > param3)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = param3 - param1 + param2;
         }
         return _loc4_;
      }
      
      private function addNpc() : void
      {
         this.removeNpc();
         this._npc = new Mobile();
         this._npc.width = 82;
         this._npc.height = 115;
         this._npc.setPostion(new Point(525,285));
         this._npc.resourceUrl = URLUtil.getNpcSwf(725);
         this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc.label = "影魔暗煞";
         this._npc.labelImage.y = -this._npc.height - 10;
         this._npc.buttonMode = true;
         this.showMouseHintAtMonster(this._npc);
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(int(this._turnNum.text) < 1)
         {
            AlertManager.showAlert("当前没有挑战次数，增加轮次后再来挑战吧!");
         }
         else
         {
            NpcDialog.show(725,"影魔暗煞",[[0,"封印了这么久是该活动活动筋骨了！这个小玩意有点意思，来过过招！"]],["挑战吧！","你和布莱克长的有点像"],[function():void
            {
               FightManager.startFightWithWild(FIGHT_INDEX);
            }]);
         }
      }
      
      private function removeNpc() : void
      {
         if(this._npc)
         {
            this.removeMouseHint();
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
            DisplayUtil.removeForParent(this._npc);
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
      
      private function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
         this._mouseHint = null;
      }
      
      private function yingMoAnShaActDispose() : void
      {
         this.removeNpc();
         this.removeMouseHint();
         this._use.removeEventListener(MouseEvent.CLICK,this.onUse);
         this._help.removeEventListener(MouseEvent.CLICK,this.onHelp);
         this._tip.removeEventListener(MouseEvent.CLICK,this.onTip);
         this._addTurn.removeEventListener(MouseEvent.CLICK,this.onAddTurn);
         this._leave.removeEventListener(MouseEvent.CLICK,this.onLeaveClick);
         this._use = null;
         this._help = null;
         this._tip = null;
         this._allHurt = null;
         this._turnNum = null;
         this._addTurn = null;
         this._leave = null;
         this._par = null;
         this._info = null;
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      override public function dispose() : void
      {
         this.yingMoAnShaActDispose();
         super.dispose();
      }
   }
}
