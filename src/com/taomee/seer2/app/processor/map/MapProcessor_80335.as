package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_80335 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [204975,204976,204977,204978,204979,204980,204981,204982,204997];
      
      private static const DAY_LIST:Array = [1425,1426,1427];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3332,3333,3335]);
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1309,1310,1311,1312,1313,1314,1315,1316,1308]);
      
      private static const NPC_ID_LIST:Vector.<int> = Vector.<int>([823,769]);
      
      private static const FIGHT_NUM:Vector.<int> = Vector.<int>([2,3]);
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605093,605091,605094,605083]);
      
      private static var _chacheDate:Vector.<int> = Vector.<int>([0]);
      
      private static const FIGHT_STATE_LIST:Vector.<int> = Vector.<int>([1328,1129,1128,1127,673,387,663]);
      
      private static const BOSS_BLOOD_MAX:int = 20;
      
      private static const AWARD_NUM:Vector.<int> = Vector.<int>([50,100,200]);
      
      private static var _isInitItemNum:Boolean = false;
      
      private static var _oldItemNum:int;
       
      
      private var _par:Parser_1142;
      
      private var _info:DayLimitListInfo;
      
      private var _resLib:ApplicationDomain;
      
      private var _npc0:Mobile;
      
      private var _fightOneUI:MovieClip;
      
      private var _miPass:SimpleButton;
      
      private var _boss:MovieClip;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _swapUI:MovieClip;
      
      private var _bar:MovieClip;
      
      private var _getAwardList:Vector.<SimpleButton>;
      
      private var _getedMarkList:Vector.<MovieClip>;
      
      private var _exitBtn:SimpleButton;
      
      private var _itemNum:TextField;
      
      private var _fightThreeUI:MovieClip;
      
      private var _goFight:SimpleButton;
      
      private var _fightTwoUI:MovieClip;
      
      private var _iceList:Vector.<MovieClip>;
      
      private var _icedList:Vector.<MovieClip>;
      
      private var _randomBtn:SimpleButton;
      
      private var _miIcePass:SimpleButton;
      
      private var _luckRandomBtn:SimpleButton;
      
      private var _fightNum:TextField;
      
      private var _curFailIndex:int;
      
      public function MapProcessor_80335(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.getURL();
      }
      
      private function getURL() : void
      {
         this.onActInit();
         QueueLoader.load(URLUtil.getActivityAnimation("QingHolyPetProcessAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            update();
         });
      }
      
      private function onActInit() : void
      {
         this.fightOneInit();
         this.fightTwoInit();
         this.fightThreeInit();
         this.swapUIInitSet();
         this._fightOneUI.visible = this._fightTwoUI.visible = this._fightThreeUI.visible = this._swapUI.visible = false;
         this._miPass.mouseEnabled = this._randomBtn.mouseEnabled = this._miIcePass.mouseEnabled = this._luckRandomBtn.mouseEnabled = false;
         this.initEvent();
      }
      
      private function initEvent() : void
      {
         var _loc1_:SimpleButton = null;
         this._miPass.addEventListener(MouseEvent.CLICK,this.onOneBossMiPass);
         this._exitBtn.addEventListener(MouseEvent.CLICK,this.onTwoBossExit);
         this._goFight.addEventListener(MouseEvent.CLICK,this.onGoFight);
         for each(_loc1_ in this._getAwardList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onGetAward);
         }
         this._randomBtn.addEventListener(MouseEvent.CLICK,this.onRandomBtn);
         this._miIcePass.addEventListener(MouseEvent.CLICK,this.onMiIcePass);
         this._luckRandomBtn.addEventListener(MouseEvent.CLICK,this.onLuckRandomBtn);
      }
      
      private function clearEvent() : void
      {
         var _loc1_:SimpleButton = null;
         this._miPass.removeEventListener(MouseEvent.CLICK,this.onOneBossMiPass);
         this._exitBtn.removeEventListener(MouseEvent.CLICK,this.onTwoBossExit);
         this._goFight.removeEventListener(MouseEvent.CLICK,this.onGoFight);
         for each(_loc1_ in this._getAwardList)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onGetAward);
         }
         this._randomBtn.removeEventListener(MouseEvent.CLICK,this.onRandomBtn);
         this._miIcePass.removeEventListener(MouseEvent.CLICK,this.onMiIcePass);
         this._luckRandomBtn.removeEventListener(MouseEvent.CLICK,this.onLuckRandomBtn);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootOver);
         this.removeNpc0HandleOne();
      }
      
      private function clearVal() : void
      {
         this._par = null;
         this._info = null;
         this._resLib = null;
         this._npc0 = null;
         this._fightOneUI = null;
         this._miPass = null;
         this._fightTwoUI = null;
         this._iceList = null;
         this._randomBtn = null;
         this._miIcePass = null;
         this._luckRandomBtn = null;
         this._fightNum = null;
         this._fightThreeUI = null;
         this._goFight = null;
         this._swapUI = null;
         this._bar = null;
         this._getAwardList = null;
         this._getedMarkList = null;
         this._exitBtn = null;
         this._mouseHint = null;
      }
      
      private function onLuckRandomBtn(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._par.infoVec[5] != 0)
         {
            AlertManager.showAlert("你已经购买了幸运砸冰，使用完再来买吧!");
         }
         else
         {
            ModuleManager.showAppModule("QingHolyPetRandomBuyPanel",{"func":function():void
            {
               updateData();
            }});
         }
      }
      
      private function onMiIcePass(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ShopManager.buyItemForId(MI_ID_LIST[1],function():void
         {
            afterMiPassFightTwo();
         });
      }
      
      private function onRandomBtn(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._par.infoVec[6] != 0)
         {
            ModuleManager.showAppModule("QingHolyPetFightPanel");
         }
         else if(int(this._fightNum.text) > 0)
         {
            this._randomBtn.mouseEnabled = false;
            if(this._par.infoVec[5] != 0)
            {
               SwapManager.swapItem(SWAP_LIST[1],1,function(param1:IDataInput):void
               {
                  var data:IDataInput = param1;
                  new SwapInfo(data);
                  updateFightTwoNum(function():void
                  {
                     _randomBtn.mouseEnabled = true;
                     ModuleManager.showAppModule("QingHolyPetFightPanel");
                  });
               },function(param1:uint):void
               {
                  _randomBtn.mouseEnabled = true;
               });
            }
            else
            {
               SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
               {
                  var data:IDataInput = param1;
                  new SwapInfo(data);
                  updateFightTwoNum(function():void
                  {
                     ModuleManager.showAppModule("QingHolyPetFightPanel");
                     _randomBtn.mouseEnabled = true;
                  });
               },function(param1:uint):void
               {
                  _randomBtn.mouseEnabled = true;
               });
            }
         }
         else
         {
            ShopManager.buyItemForId(MI_ID_LIST[2],function():void
            {
               updateFightTwoNum();
            });
         }
      }
      
      private function updateFightTwoNum(param1:Function = null) : void
      {
         var func:Function = param1;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               _fightNum.text = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[1]),_par.infoVec[2],VipManager.vipInfo.isVip() ? FIGHT_NUM[1] : FIGHT_NUM[0]).toString();
               if(func != null)
               {
                  func();
               }
            });
         });
      }
      
      private function onGetAward(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         var index:int = this._getAwardList.indexOf(evt.currentTarget as SimpleButton);
         SwapManager.swapItem(SWAP_LIST[2],1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            updateBar();
         },null,new SpecialInfo(1,index + 1));
      }
      
      private function updateBar() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               getBarStateHandle();
            });
         });
      }
      
      private function onGoFight(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.COPY,80336);
      }
      
      private function onTwoBossExit(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function onOneBossMiPass(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ShopManager.buyItemForId(MI_ID_LIST[0],function():void
         {
            stateTwoHandle();
         });
      }
      
      private function update() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               if(par.infoVec[0] == 0)
               {
                  stateOneHandle();
               }
               if(par.infoVec[0] == 1)
               {
                  stateTwoHandle();
               }
               _miPass.mouseEnabled = _randomBtn.mouseEnabled = _miIcePass.mouseEnabled = _luckRandomBtn.mouseEnabled = true;
            });
         });
      }
      
      private function fightOneInit() : void
      {
         this._fightOneUI = _map.front["fightOneUI"] as MovieClip;
         this._miPass = this._fightOneUI["miPass"] as SimpleButton;
      }
      
      private function stateOneHandle() : void
      {
         var _scenMc:MovieClip = null;
         if(_chacheDate[0] == 1)
         {
            this.addNpc0(NPC_ID_LIST[1]);
            this._fightOneUI.visible = true;
            this._npc0.addEventListener(MouseEvent.CLICK,this.onNpc0HandleTwo);
         }
         else
         {
            _scenMc = this.getMovie("SceneMC0");
            _map.front.addChild(_scenMc);
            MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_scenMc);
               _scenMc = null;
               addNpc0(NPC_ID_LIST[0]);
               _npc0.addEventListener(MouseEvent.CLICK,onNpc0HandleOne);
            },true);
         }
      }
      
      private function addNpc0(param1:int) : void
      {
         this._npc0 = new Mobile();
         this._npc0.width = 82;
         this._npc0.height = 150;
         this._npc0.setPostion(new Point(440,340));
         this._npc0.resourceUrl = URLUtil.getNpcSwf(param1);
         this._npc0.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc0.label = "梦魇";
         this._npc0.labelImage.y = -this._npc0.height - 10;
         this._npc0.buttonMode = true;
         this.showMouseHintAtMonster(this._npc0);
         MobileManager.addMobile(this._npc0,MobileType.NPC);
      }
      
      private function onNpc0HandleOne(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(823,"梦魇",[[0,"别和我说你要找沁灵兽！"]],["（NONO，我们就是来找沁灵兽的啊）","切！"],[function():void
         {
            NpcDialog.show(113,"NONO",[[0,"这……开场白都这样的啊，点它点它，策划就是这么设计的！"]],["……"],[function():void
            {
               NpcDialog.show(823,"梦魇",[[0,"破了我这黑冰再说！"]],["来吧"],[function():void
               {
                  removeNpc0HandleOne();
                  addBoss();
               }]);
            }]);
         }]);
      }
      
      private function removeNpc0HandleOne() : void
      {
         if(this._npc0)
         {
            this._npc0.removeEventListener(MouseEvent.CLICK,this.onNpc0HandleOne);
            this._npc0.removeEventListener(MouseEvent.CLICK,this.onNpc0HandleTwo);
            DisplayObjectUtil.removeFromParent(this._npc0);
            this._npc0 = null;
         }
      }
      
      private function addBoss() : void
      {
         this._boss = this.getMovie("Boss");
         this._boss.x = 350;
         this._boss.y = 142;
         this._boss.curBlood = BOSS_BLOOD_MAX;
         _map.content.addChild(this._boss);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootOver);
      }
      
      private function onShootOver(param1:ShootEvent) : void
      {
         var _loc2_:ShootInfo = param1.info;
         if(this._boss.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            --this._boss.curBlood;
            this.updateBlood(this._boss);
            if(this._boss.curBlood <= 0)
            {
               DisplayUtil.removeForParent(this._boss);
               ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootOver);
               this.playBeatOkAnim(this._boss);
            }
         }
      }
      
      private function playBeatOkAnim(param1:MovieClip) : void
      {
         var anima:MovieClip = null;
         var val:MovieClip = param1;
         anima = this.getMovie("BossDeathMC");
         _map.content.addChild(anima);
         anima.x = val.x + 25;
         anima.y = val.y - 45;
         MovieClipUtil.playMc(anima,2,anima.totalFrames,function():void
         {
            DisplayUtil.removeForParent(anima);
            addNpc0(NPC_ID_LIST[1]);
            _chacheDate[0] = 1;
            (_map.front["fightOneUI"] as MovieClip).visible = true;
            _npc0.addEventListener(MouseEvent.CLICK,onNpc0HandleTwo);
         },true);
      }
      
      private function onNpc0HandleTwo(param1:MouseEvent = null) : void
      {
         var evt:MouseEvent = param1;
         var canFightNum:int = ActsHelperUtil.getCanNum(this._info.getCount(DAY_LIST[0]),this._par.infoVec[1],VipManager.vipInfo.isVip() ? FIGHT_NUM[1] : FIGHT_NUM[0]);
         if(canFightNum > 0)
         {
            NpcDialog.show(769,"梦魇",[[0,"接下来你应该知道要做什么了吧？打败我再来谈条件，你今天还有<font color=\'#ffcc00\'> " + canFightNum.toString() + " </font>次机会！"]],["我准备好了！","我要酝酿一下情绪"],[function():void
            {
               FightManager.startFightWithWild(FIGHT_INDEX_LIST[8]);
            }]);
         }
         else
         {
            NpcDialog.show(769,"梦魇",[[0,"切，你今天已经没有机会了，明天再来试试吧！"]],["购买挑战","明天有你好看！"],[function():void
            {
               ShopManager.buyItemForId(MI_ID_LIST[3],function():void
               {
                  updateData(function():void
                  {
                     FightManager.startFightWithWild(FIGHT_INDEX_LIST[8]);
                  });
               });
            }]);
         }
      }
      
      private function setFuncDisable() : void
      {
         this.setFuncUiEnable(false);
      }
      
      private function setFuncUiEnable(param1:Boolean) : void
      {
         this._fightOneUI.mouseEnabled = this._fightOneUI.mouseChildren = param1;
         this._fightTwoUI.mouseEnabled = this._fightTwoUI.mouseChildren = param1;
         this._fightThreeUI.mouseEnabled = this._fightThreeUI.mouseChildren = param1;
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
               _par = par;
               _info = param1;
               setFuncUiEnable(true);
               if(func != null)
               {
                  func();
               }
            });
         });
      }
      
      private function updateBlood(param1:MovieClip) : void
      {
         if(param1)
         {
            (param1["bloodShow"]["bar"] as MovieClip).scaleX = Number(param1.curBlood / BOSS_BLOOD_MAX);
         }
      }
      
      private function shootDispose() : void
      {
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootOver);
         if(this._boss)
         {
            DisplayUtil.removeForParent(this._boss);
            this._boss = null;
         }
      }
      
      private function showMouseHintAtMonster(param1:Sprite) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -param1.height - 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
         param1.addChild(this._mouseHint);
      }
      
      private function stateTwoHandle() : void
      {
         this.removeNpc0HandleOne();
         this._fightOneUI.visible = false;
         this._swapUI.visible = true;
         ServerBufferManager.getServerBuffer(ServerBufferType.QING_HOLY_PET_PROCESS,function(param1:ServerBuffer):void
         {
            var _scenMc:MovieClip = null;
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
            if(!_isPlay)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.QING_HOLY_PET_PROCESS,1,1);
               _scenMc = getMovie("SceneMC1");
               _map.front.addChild(_scenMc);
               MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_scenMc);
                  _scenMc = null;
                  _fightTwoUI.visible = true;
                  iceStateHandle();
                  getBarStateHandle();
               },true);
            }
            else
            {
               _fightTwoUI.visible = true;
               iceStateHandle();
               getBarStateHandle();
            }
         });
         this._fightNum.text = ActsHelperUtil.getCanNum(this._info.getCount(DAY_LIST[1]),this._par.infoVec[2],VipManager.vipInfo.isVip() ? FIGHT_NUM[1] : FIGHT_NUM[0]).toString();
      }
      
      private function swapUIInitSet() : void
      {
         this._swapUI = _map.front["swapUI"];
         this._bar = this._swapUI["bar"] as MovieClip;
         this._getAwardList = new Vector.<SimpleButton>();
         this._getedMarkList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._getAwardList.push(this._swapUI["getAward" + _loc1_]);
            this._getedMarkList.push(this._swapUI["getedMark" + _loc1_]);
            _loc1_++;
         }
         this._exitBtn = this._swapUI["exitBtn"];
         this._itemNum = this._swapUI["itemNum"];
      }
      
      private function fightThreeInit() : void
      {
         this._fightThreeUI = _map.front["fightThreeUI"] as MovieClip;
         this._goFight = this._fightThreeUI["goFight"];
      }
      
      private function fightTwoInit() : void
      {
         this._fightTwoUI = _map.front["fightTwoUI"];
         this._iceList = new Vector.<MovieClip>();
         this._icedList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this._iceList.push(this._fightTwoUI["ice" + _loc1_]);
            this._icedList.push(this._fightTwoUI["iced" + _loc1_]);
            _loc1_++;
         }
         this._randomBtn = this._fightTwoUI["randomBtn"];
         this._miIcePass = this._fightTwoUI["miIcePass"];
         this._luckRandomBtn = this._fightTwoUI["luckRandomBtn"];
         this._fightNum = this._fightTwoUI["fightNum"];
      }
      
      private function iceStateHandle() : void
      {
         var fightId:int = 0;
         var index:int = 0;
         var i:int = 0;
         var curIndex:int = 0;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            fightId = int(FightManager.currentFightRecord.initData.positionIndex);
            index = FIGHT_INDEX_LIST.indexOf(fightId);
            i = 0;
            if(index >= 0 && index <= 6)
            {
               if(FightManager.fightWinnerSide == FightSide.RIGHT)
               {
                  this._curFailIndex = index;
                  i = 0;
                  while(i < 4)
                  {
                     if(BitUtil.getBit(this._par.infoVec[4],i))
                     {
                        this._iceList[i].gotoAndStop(this._iceList[i].totalFrames);
                        this._icedList[i].gotoAndStop(2);
                     }
                     else
                     {
                        this._iceList[i].gotoAndStop(1);
                        this._icedList[i].gotoAndStop(1);
                     }
                     i++;
                  }
                  ModuleManager.showAppModule("QingHolyPetFailPanel",{
                     "func":this.winFailGateHandle,
                     "index":index
                  });
               }
               else if(index <= 3)
               {
                  i = 0;
                  while(i < 4)
                  {
                     if(i != index)
                     {
                        if(BitUtil.getBit(this._par.infoVec[4],i))
                        {
                           this._iceList[i].gotoAndStop(this._iceList[i].totalFrames);
                           this._icedList[i].gotoAndStop(2);
                        }
                        else
                        {
                           this._iceList[i].gotoAndStop(1);
                           this._icedList[i].gotoAndStop(1);
                        }
                     }
                     else if(BitUtil.getBit(this._par.infoVec[4],i))
                     {
                        curIndex = i;
                        MovieClipUtil.playMc(this._iceList[curIndex],2,this._iceList[curIndex].totalFrames,function():void
                        {
                           _iceList[curIndex].gotoAndStop(_iceList[curIndex].totalFrames);
                           _icedList[curIndex].gotoAndStop(2);
                           if(_par.infoVec[4] == 15)
                           {
                              afterMiPassFightTwo();
                           }
                        });
                     }
                     else
                     {
                        this._iceList[i].gotoAndStop(1);
                        this._icedList[i].gotoAndStop(1);
                     }
                     i++;
                  }
               }
            }
            else
            {
               i = 0;
               while(i < 4)
               {
                  if(BitUtil.getBit(this._par.infoVec[4],i))
                  {
                     this._iceList[i].gotoAndStop(this._iceList[i].totalFrames);
                     this._icedList[i].gotoAndStop(2);
                  }
                  else
                  {
                     this._iceList[i].gotoAndStop(1);
                     this._icedList[i].gotoAndStop(1);
                  }
                  i++;
               }
            }
         }
         else
         {
            i = 0;
            while(i < 4)
            {
               if(BitUtil.getBit(this._par.infoVec[4],i))
               {
                  this._iceList[i].gotoAndStop(this._iceList[i].totalFrames);
                  this._icedList[i].gotoAndStop(2);
               }
               else
               {
                  this._iceList[i].gotoAndStop(1);
                  this._icedList[i].gotoAndStop(1);
               }
               i++;
            }
            if(this._par.infoVec[4] == 15)
            {
               this.afterMiPassFightTwo();
            }
         }
      }
      
      private function winFailGateHandle() : void
      {
         this.updateData(function():void
         {
            var curIndex:int = 0;
            var i:int = 0;
            while(i < 4)
            {
               if(i != _curFailIndex)
               {
                  if(BitUtil.getBit(_par.infoVec[4],i))
                  {
                     _iceList[i].gotoAndStop(_iceList[i].totalFrames);
                     _icedList[i].gotoAndStop(2);
                  }
                  else
                  {
                     _iceList[i].gotoAndStop(1);
                     _icedList[i].gotoAndStop(1);
                  }
               }
               else if(BitUtil.getBit(_par.infoVec[4],i))
               {
                  curIndex = i;
                  MovieClipUtil.playMc(_iceList[curIndex],2,_iceList[curIndex].totalFrames,function():void
                  {
                     _iceList[curIndex].gotoAndStop(_iceList[curIndex].totalFrames);
                     _icedList[curIndex].gotoAndStop(2);
                     if(_par.infoVec[4] == 15)
                     {
                        afterMiPassFightTwo();
                     }
                  });
               }
               else
               {
                  _iceList[i].gotoAndStop(1);
                  _icedList[i].gotoAndStop(1);
               }
               i++;
            }
            itemNumHandle();
         });
      }
      
      private function afterMiPassFightTwo() : void
      {
         var _scenMc:MovieClip = null;
         this._fightTwoUI.visible = false;
         _scenMc = this.getMovie("SceneMC2");
         _map.front.addChild(_scenMc);
         MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
         {
            _scenMc.gotoAndStop(_scenMc.totalFrames);
            _fightThreeUI.visible = true;
            _map.front.setChildIndex(_fightThreeUI,_map.front.numChildren - 1);
         },true);
         this.updateData(function():void
         {
            itemNumHandle();
         });
      }
      
      private function getBarStateHandle() : void
      {
         this._bar.scaleY = this._par.infoVec[8] / AWARD_NUM[2] > 1 ? 1 : this._par.infoVec[8] / AWARD_NUM[2];
         var _loc1_:int = 0;
         while(_loc1_ < AWARD_NUM.length)
         {
            if(this._par.infoVec[8] >= AWARD_NUM[_loc1_])
            {
               if(BitUtil.getBit(this._par.infoVec[7],_loc1_))
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
               this._getedMarkList[_loc1_].visible = false;
               DisplayObjectUtil.disableButton(this._getAwardList[_loc1_]);
            }
            _loc1_++;
         }
         this.itemNumHandle();
      }
      
      private function itemNumHandle() : void
      {
         if(!_isInitItemNum)
         {
            this._itemNum.text = this._par.infoVec[8].toString();
            _oldItemNum = this._par.infoVec[8];
            _isInitItemNum = true;
         }
         else
         {
            if(this._par.infoVec[8] > _oldItemNum)
            {
               ServerMessager.addMessage("恭喜你获得" + (this._par.infoVec[8] - _oldItemNum) + "个沁灵!");
            }
            this._itemNum.text = this._par.infoVec[8].toString();
            _oldItemNum = this._par.infoVec[8];
         }
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function onActDispose() : void
      {
         this.clearEvent();
         this.clearVal();
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
