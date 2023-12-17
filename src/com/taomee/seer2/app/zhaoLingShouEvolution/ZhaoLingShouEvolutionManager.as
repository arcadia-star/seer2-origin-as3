package com.taomee.seer2.app.zhaoLingShouEvolution
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.scene.LobbyPanel;
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
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class ZhaoLingShouEvolutionManager
   {
       
      
      private var _map:MapModel;
      
      private var _appDomain:ApplicationDomain;
      
      private const animationPos:Array = [new Point(632,342),new Point(632,342),new Point(283,112)];
      
      private var _mainUI:MovieClip;
      
      private var _sphinxMc:MovieClip;
      
      private var _pyramidMc:MovieClip;
      
      private var _lightMcList:Vector.<MovieClip>;
      
      private var _barMc:MovieClip;
      
      private var _markMcList:Vector.<MovieClip>;
      
      private var _itemMcList:Vector.<MovieClip>;
      
      private var _swapBtnList:Vector.<SimpleButton>;
      
      private var _exitBtn:SimpleButton;
      
      private var _oneKeyPassBtn:SimpleButton;
      
      private var _activeMc:MovieClip;
      
      private var mouseClickMc:MouseClickHintSprite;
      
      private const FOR_LIST:Array = [206203,206204,206208,206205];
      
      private const DAY_LIST:Array = [1852];
      
      private const SWAP_LIST:Array = [4429];
      
      private const BOSS_ID:uint = 1743;
      
      private const NPC_ID:uint = 1744;
      
      private const FIGHT_ID:Array = [1737,1738,1739,1740,1741,1742];
      
      private const ITME_TIPS:Array = ["8W赛尔豆","精元晶石*10","进化芯片"];
      
      private var _baduNpc:Mobile;
      
      private var _zhaoNpc:Mobile;
      
      public function ZhaoLingShouEvolutionManager(param1:MapModel)
      {
         super();
         this._map = param1;
         this._mainUI = this._map.front["MainUI"];
         this._mainUI.visible = false;
         this._pyramidMc = this._map.content["pyramidMc"];
         this._lightMcList = new Vector.<MovieClip>();
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            this._lightMcList.push(this._map.front["light" + _loc2_]);
            this._lightMcList[_loc2_].visible = false;
            _loc2_++;
         }
         this._map.content.setChildIndex(this._pyramidMc,0);
         this.loadSwfFile();
      }
      
      private function loadSwfFile() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("zhaoLingShouEvolutionAct"),LoadType.SWF,function onComplete(param1:ContentInfo):void
         {
            _appDomain = param1.domain;
            initView();
            initEvent();
         });
      }
      
      private function getMovieClip(param1:String) : MovieClip
      {
         if(this._appDomain)
         {
            return DomainUtil.getMovieClip(param1,this._appDomain);
         }
         return null;
      }
      
      private function playSceneAnimation(param1:String, param2:int = -1, param3:Function = null) : void
      {
         var animation:MovieClip = null;
         var className:String = param1;
         var posIndex:int = param2;
         var callback:Function = param3;
         animation = this.getMovieClip(className);
         if(animation != null)
         {
            animation.gotoAndStop(1);
            if(posIndex != -1)
            {
               animation.x = (this.animationPos[posIndex] as Point).x;
               animation.y = (this.animationPos[posIndex] as Point).y;
            }
            this._map.front.addChild(animation);
            MovieClipUtil.playMc(animation,1,animation.totalFrames,function complete():void
            {
               _map.front.removeChild(animation);
               animation = null;
               if(callback != null)
               {
                  callback();
               }
            },true);
         }
      }
      
      private function initView() : void
      {
         LobbyPanel.instance.hide();
         this._sphinxMc = this._map.content["sphinxMc"];
         this._exitBtn = this._mainUI["exitBtn"];
         this._activeMc = this._mainUI["activeMc"];
         this._oneKeyPassBtn = this._mainUI["oneKeyPass"];
         this._barMc = this._mainUI["barMc"];
         this._swapBtnList = new Vector.<SimpleButton>();
         this._markMcList = new Vector.<MovieClip>();
         this._itemMcList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this._swapBtnList.push(this._mainUI["swapBtn" + _loc1_]);
            DisplayObjectUtil.disableButton(this._swapBtnList[_loc1_]);
            this._markMcList.push(this._mainUI["markMc" + _loc1_]);
            this._markMcList[_loc1_].visible = false;
            this._itemMcList.push(this._mainUI["itemMc" + _loc1_]);
            TooltipManager.addCommonTip(this._itemMcList[_loc1_],this.ITME_TIPS[_loc1_]);
            _loc1_++;
         }
         this.updateUI();
      }
      
      private function initEvent() : void
      {
         this._exitBtn.addEventListener(MouseEvent.CLICK,this.onExitBtn);
         this._activeMc.addEventListener(MouseEvent.CLICK,this.onActiveMc);
         this._oneKeyPassBtn.addEventListener(MouseEvent.CLICK,this.onOneKeyPassBtn);
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this._swapBtnList.length)
         {
            this._swapBtnList[_loc1_].addEventListener(MouseEvent.CLICK,this.onSwapBtn);
            _loc1_++;
         }
      }
      
      private function onExitBtn(param1:MouseEvent) : void
      {
         this._mainUI.visible = false;
         LobbyPanel.instance.show();
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function onActiveMc(param1:MouseEvent) : void
      {
         if(1 == param1.currentTarget.currentFrame)
         {
            ModuleManager.showAppModule("ZhaoLingShouEvolutionFightPanel");
         }
         else if(2 == param1.currentTarget.currentFrame)
         {
            SceneManager.changeScene(SceneType.LOBBY,1190);
         }
      }
      
      private function onOneKeyPassBtn(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ShopManager.buyItemForId(606776,function(param1:*):void
         {
            showZhaoNpc();
            updateUI();
         });
      }
      
      private function onSwapBtn(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         var index:int = this._swapBtnList.indexOf(evt.currentTarget as SimpleButton);
         if(-1 != index)
         {
            SwapManager.swapItem(this.SWAP_LIST[0],1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               updateUI();
            },null,new SpecialInfo(1,index));
         }
      }
      
      private function onBaduClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(3087,"巴度",[[0,"不好了，爪灵兽被一股十分强大的神秘力量给封印住了。"]],["。。。。。。"],[function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"啊？是什么神秘力量？"]],["（NONO，我们怎么办？）"],[function():void
            {
               NpcDialog.show(3087,"巴度",[[0,"目前我也不清楚，但我知道只有真正的强者才能够有资格解救爪灵兽。"]],[" 让我来试试吧。"],[function():void
               {
                  _baduNpc.visible = false;
                  FightManager.startFightWithWild(NPC_ID);
               }]);
            }]);
         }]);
      }
      
      private function onSphinxMcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._sphinxMc.removeEventListener(MouseEvent.CLICK,this.onSphinxMcClick);
         this._sphinxMc.removeChild(this.mouseClickMc);
         this.playSceneAnimation("Mc2",1,function callback():void
         {
            _mainUI.visible = true;
         });
      }
      
      private function onZhaoNpc(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ActiveCountManager.requestActiveCountList(this.FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               var info:DayLimitListInfo = param1;
               var canNum:int = ActsHelperUtil.getCanNum(info.getCount(DAY_LIST[0]),par.infoVec[3],1);
               if(canNum > 0)
               {
                  NpcDialog.show(3088,"爪灵神",[[0,"我将用强大的力量击碎一切！"]],["让我来！","不打了，被打倒一定很疼！"],[function():void
                  {
                     FightManager.startFightWithWild(BOSS_ID);
                  }]);
               }
               else
               {
                  ShopManager.buyItemForId(606778,function complete():void
                  {
                     FightManager.startFightWithWild(BOSS_ID);
                  });
               }
            });
         });
      }
      
      private function createNpc(param1:uint, param2:String, param3:Point = null, param4:Boolean = false, param5:Point = null) : Mobile
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:MouseClickHintSprite = null;
         var _loc6_:Mobile;
         (_loc6_ = new Mobile()).label = param2;
         _loc6_.labelPosition = MobileLabelPosition.OVER_HEAD;
         _loc6_.resourceUrl = URLUtil.getNpcSwf(param1);
         if(param3 == null)
         {
            _loc7_ = (1200 - _loc6_.width) / 2;
            _loc8_ = (660 - _loc6_.height) / 2;
            _loc6_.setPostion(new Point(_loc7_,_loc8_));
         }
         else
         {
            _loc6_.setPostion(param3);
         }
         if(param4)
         {
            _loc6_.buttonMode = true;
            (_loc9_ = new MouseClickHintSprite()).x = param5.x;
            _loc9_.y = param5.y;
            _loc6_.addChild(_loc9_);
         }
         return _loc6_;
      }
      
      private function updateUI() : void
      {
         ActiveCountManager.requestActiveCountList(this.FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            var curFightId:int = int(FightManager.currentFightRecord.initData.positionIndex);
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(curFightId == NPC_ID)
               {
                  NpcDialog.show(3087,"巴度",[[0,"不错，你完全拥有拯救爪灵兽的能力，真正的考验从那个狮身人面像开始，快去看看吧。"]],["好的！"],[function():void
                  {
                     mouseClickMc = new MouseClickHintSprite();
                     mouseClickMc.x = 90;
                     mouseClickMc.y = 10;
                     _sphinxMc.addChild(mouseClickMc);
                     _sphinxMc.buttonMode = true;
                     _sphinxMc.addEventListener(MouseEvent.CLICK,onSphinxMcClick);
                  }]);
               }
               else if(-1 != FIGHT_ID.indexOf(curFightId) && par.infoVec[0] == 63)
               {
                  showLight(par);
                  Tick.instance.addTimeout(2000,function timeOut():void
                  {
                     var i:int = 0;
                     i = 0;
                     while(i < _lightMcList.length)
                     {
                        _lightMcList[i].visible = false;
                        i++;
                     }
                     _pyramidMc.visible = false;
                     playSceneAnimation("Mc3",2,function callback():void
                     {
                        showZhaoNpc();
                     });
                  });
               }
               else if(curFightId == BOSS_ID)
               {
                  showZhaoNpc();
                  showUI(par);
               }
               else
               {
                  showLight(par);
                  showUI(par);
               }
            }
            else if(par.infoVec[0] == 0)
            {
               playSceneAnimation("Mc1",0,function callback():void
               {
                  _baduNpc = createNpc(3087,"",new Point(1020,550),true,new Point(-10,-100));
                  MobileManager.addMobile(_baduNpc,MobileType.NPC);
                  _baduNpc.addEventListener(MouseEvent.CLICK,onBaduClick);
                  _map.content.addChild(_baduNpc);
               });
            }
            else
            {
               if(par.infoVec[0] == 63)
               {
                  showZhaoNpc();
               }
               else
               {
                  showLight(par);
               }
               showUI(par);
            }
         });
      }
      
      private function showUI(param1:Parser_1142) : void
      {
         if(param1.infoVec[0] == 63)
         {
            this._oneKeyPassBtn.visible = false;
            this._activeMc.visible = false;
         }
         var _loc2_:Array = [50,100,200];
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            if(BitUtil.getBit(param1.infoVec[2],_loc3_))
            {
               this._markMcList[_loc3_].visible = true;
            }
            else if(param1.infoVec[1] >= _loc2_[_loc3_])
            {
               DisplayObjectUtil.enableButton(this._swapBtnList[_loc3_]);
            }
            _loc3_++;
         }
         var _loc4_:int = (_loc4_ = int(param1.infoVec[1] * 0.5)) > 100 ? 100 : _loc4_;
         this._barMc.gotoAndStop(_loc4_);
         TooltipManager.addCommonTip(this._barMc,_loc4_.toString());
         this._mainUI.visible = true;
      }
      
      private function showLight(param1:Parser_1142) : void
      {
         var _loc2_:int = 0;
         if(param1.infoVec[0] > 0)
         {
            this._lightMcList[6].visible = true;
            _loc2_ = 0;
            while(_loc2_ < 6)
            {
               if(BitUtil.getBit(param1.infoVec[0],_loc2_))
               {
                  this._lightMcList[_loc2_].visible = true;
               }
               _loc2_++;
            }
         }
      }
      
      private function showZhaoNpc() : void
      {
         this._pyramidMc.visible = false;
         if(this._zhaoNpc == null)
         {
            this._zhaoNpc = this.createNpc(3088,"",new Point(468,370),true,new Point(-20,-210));
            this._zhaoNpc.addEventListener(MouseEvent.CLICK,this.onZhaoNpc);
            MobileManager.addMobile(this._zhaoNpc,MobileType.NPC);
            this._map.content.addChild(this._zhaoNpc);
         }
         else
         {
            this._zhaoNpc.visible = true;
         }
      }
      
      public function dispose() : void
      {
         if(this._mainUI)
         {
            DisplayObjectUtil.removeFromParent(this._mainUI);
            this._mainUI = null;
         }
         if(this._exitBtn)
         {
            this._exitBtn.removeEventListener(MouseEvent.CLICK,this.onExitBtn);
         }
         if(this._baduNpc)
         {
            MobileManager.removeMobile(this._baduNpc,MobileType.NPC);
            this._baduNpc = null;
         }
         if(this._zhaoNpc)
         {
            MobileManager.removeMobile(this._zhaoNpc,MobileType.NPC);
            this._zhaoNpc = null;
         }
      }
   }
}
