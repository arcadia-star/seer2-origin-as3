package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.MatchingConfig;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.filter.ColorFilter;
   
   public class SixStarLoopFormationAct
   {
      
      private static var _instance:com.taomee.seer2.app.actives.SixStarLoopFormationAct;
       
      
      private const FIGHTLOOP_STATE_ID1:uint = 771;
      
      private const FIGHTLOOP_STATE_ID2:uint = 772;
      
      private const FIGHT6V6_STATE_ID:uint = 767;
      
      private const FIGHTBOSS_STATE_ID:uint = 768;
      
      private const FIGHTLOOP_ID:Array = [543,544,545,546,547,548];
      
      private const FIGHT6V6_ID:uint = 549;
      
      private const FIGHTBOSS_ID:uint = 550;
      
      private const RESET_SWAP_ID:int = 1710;
      
      private const LINE_STATE1:Array = ["12","23","34","45","56","61","13","35","15","24","46","26","14","25","36"];
      
      private const LINE_STATE2:Array = ["21","32","43","54","65","16","31","53","51","42","64","62","41","52","63"];
      
      private const LOOPNPC_SEAT:Array = [new Point(522,203),new Point(235,276),new Point(199,398),new Point(504,449),new Point(820,348),new Point(802,233)];
      
      private const MI_COUNT_ID:uint = 603193;
      
      private const MI_PASS_ID:uint = 603194;
      
      private const NPCBOSS_ID:uint = 616;
      
      private const NPC6V6_ID:uint = 615;
      
      private const LOOPNPC_ID:Array = [612,610,611,609,614,613];
      
      private var line_list:Vector.<MovieClip>;
      
      private var map_model:MapModel;
      
      private var centerNpc:Mobile;
      
      private var loopNpc:Vector.<Mobile>;
      
      private var resetBtn:SimpleButton;
      
      private var ruleBtn:SimpleButton;
      
      private var buyPassBtn:SimpleButton;
      
      private var buyCountBtn:SimpleButton;
      
      private var buyItemBtn:SimpleButton;
      
      private var vipBtn:SimpleButton;
      
      private var eftMc:MovieClip;
      
      private var show6v6Eft:MovieClip;
      
      private var showBossEft:MovieClip;
      
      private var fightloop_state:Array;
      
      private var fight6v6_state:uint;
      
      private var fightboss_state:uint;
      
      private var centerNpcId:uint;
      
      private var hasDrawComplete:Boolean = false;
      
      private var isBuyPass:Boolean;
      
      public function SixStarLoopFormationAct()
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.actives.SixStarLoopFormationAct
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.actives.SixStarLoopFormationAct();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(this.centerNpc)
         {
            this.centerNpc.removeEventListener(MouseEvent.CLICK,this.toFight);
            this.centerNpc = null;
         }
         if(this.loopNpc)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               this.loopNpc[_loc1_].removeEventListener(MouseEvent.CLICK,this.toLoopFight);
               _loc1_++;
            }
         }
         this.resetBtn.removeEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.ruleBtn.removeEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.buyPassBtn.removeEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.buyCountBtn.removeEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.buyItemBtn.removeEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.vipBtn.removeEventListener(MouseEvent.CLICK,this.btnClickHandler);
         TooltipManager.remove(this.ruleBtn);
         TooltipManager.remove(this.buyPassBtn);
         TooltipManager.remove(this.buyCountBtn);
         TooltipManager.remove(this.buyItemBtn);
         TooltipManager.remove(this.vipBtn);
         this.hasDrawComplete = false;
      }
      
      public function setup() : void
      {
         this.map_model = SceneManager.active.mapModel;
         this.initLine();
         this.getData();
         ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57,this.getBuffer);
      }
      
      private function getBuffer(param1:ServerBuffer) : void
      {
         var _loc2_:Boolean = Boolean(param1.readDataAtPostion(24));
         if(!_loc2_)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("SixStarRulePanel"));
            ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_57,24,1);
         }
      }
      
      private function initLine() : void
      {
         this.line_list = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 15)
         {
            this.line_list.push(this.map_model.content["line" + _loc1_]);
            this.line_list[_loc1_].visible = false;
            this.line_list[_loc1_].mouseChildren = this.line_list[_loc1_].mouseEnabled = false;
            _loc1_++;
         }
         this.resetBtn = this.map_model.content["resetBtn"];
         this.ruleBtn = this.map_model.content["ruleBtn"];
         this.buyPassBtn = this.map_model.content["buyPassBtn"];
         this.buyCountBtn = this.map_model.content["buyCountBtn"];
         this.buyItemBtn = this.map_model.content["buyItemBtn"];
         this.vipBtn = this.map_model.content["vipBtn"];
         this.show6v6Eft = this.map_model.content["show6v6Eft"];
         this.showBossEft = this.map_model.content["showBossEft"];
         this.show6v6Eft.stop();
         this.showBossEft.stop();
         this.show6v6Eft.mouseChildren = this.show6v6Eft.mouseEnabled = this.showBossEft.mouseChildren = this.showBossEft.mouseEnabled = false;
         DisplayObjectUtil.removeFromParent(this.show6v6Eft);
         DisplayObjectUtil.removeFromParent(this.showBossEft);
         this.initEvent();
      }
      
      private function initEvent() : void
      {
         this.resetBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.ruleBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.buyPassBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.buyCountBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.buyItemBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.vipBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         TooltipManager.addCommonTip(this.ruleBtn,"挑战观星者规则");
         TooltipManager.addCommonTip(this.buyPassBtn,"一键开启六芒星阵");
         TooltipManager.addCommonTip(this.buyCountBtn,"再次挑战观星者部位及真身");
         TooltipManager.addCommonTip(this.buyItemBtn,"有助于战斗提升的药剂");
         TooltipManager.addCommonTip(this.vipBtn,"快速成为VIP");
      }
      
      private function btnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         switch(param1.target)
         {
            case this.resetBtn:
               this.toReset();
               _loc3_ = "0x10034011";
               break;
            case this.ruleBtn:
               ModuleManager.toggleModule(URLUtil.getAppModule("SixStarRulePanel"));
               _loc3_ = "0x1003400c";
               break;
            case this.buyPassBtn:
               _loc2_ = new BuyPropInfo();
               _loc2_.itemId = this.MI_PASS_ID;
               _loc2_.buyComplete = this.buyComplete;
               ShopManager.buyVirtualItem(_loc2_);
               _loc3_ = "0x1003400d";
               break;
            case this.buyCountBtn:
               _loc4_ = VipManager.vipInfo.isVip() ? 2 : 1;
               if(this.fightboss_state < _loc4_)
               {
                  AlertManager.showAlert("你还有" + (_loc4_ - this.fightboss_state) + "次挑战机会，不用购买挑战次数！");
                  return;
               }
               _loc2_ = new BuyPropInfo();
               _loc2_.itemId = this.MI_COUNT_ID;
               _loc2_.buyComplete = this.buyComplete;
               ShopManager.buyVirtualItem(_loc2_);
               _loc3_ = "0x1003400e";
               break;
            case this.buyItemBtn:
               ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
               _loc3_ = "0x1003400f";
               break;
            case this.vipBtn:
               ModuleManager.toggleModule(URLUtil.getAppModule("VipRechargeBasePanel"));
               _loc3_ = "0x10034010";
         }
         StatisticsManager.sendNovice(_loc3_);
      }
      
      private function buyComplete(param1:Parser_1224) : void
      {
         this.hideLine();
         if(param1.itemId == MatchingConfig.getNewId(this.MI_PASS_ID))
         {
            this.isBuyPass = true;
         }
         this.getData();
      }
      
      private function getData() : void
      {
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.writeUnsignedInt(4);
         _loc1_.writeUnsignedInt(this.FIGHTLOOP_STATE_ID1);
         _loc1_.writeUnsignedInt(this.FIGHTLOOP_STATE_ID2);
         _loc1_.writeUnsignedInt(this.FIGHT6V6_STATE_ID);
         _loc1_.writeUnsignedInt(this.FIGHTBOSS_STATE_ID);
         DayLimitListManager.getDoCount(_loc1_,this.getDayLimitList);
      }
      
      private function getDayLimitList(param1:DayLimitListInfo) : void
      {
         var _loc2_:Array = null;
         this.fightloop_state = param1.getCount(this.FIGHTLOOP_STATE_ID1).toString().split("");
         this.fightloop_state.reverse();
         if(this.fightloop_state.length >= 7 && param1.getCount(this.FIGHTLOOP_STATE_ID2) != 0)
         {
            _loc2_ = param1.getCount(this.FIGHTLOOP_STATE_ID2).toString().split("");
            _loc2_.reverse();
            this.fightloop_state = this.fightloop_state.concat(_loc2_);
         }
         this.fight6v6_state = param1.getCount(this.FIGHT6V6_STATE_ID);
         this.fightboss_state = param1.getCount(this.FIGHTBOSS_STATE_ID);
         this.checkLineComplete();
      }
      
      private function checkLineComplete() : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc1_:uint = this.fightloop_state.length;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_ - 1)
         {
            _loc4_ = String(this.fightloop_state[_loc3_].toString() + this.fightloop_state[_loc3_ + 1].toString());
            if((_loc5_ = this.LINE_STATE1.indexOf(_loc4_)) == -1)
            {
               _loc5_ = this.LINE_STATE2.indexOf(_loc4_);
            }
            if(_loc5_ > 11 || _loc5_ == -1)
            {
               _loc2_ = true;
            }
            if(_loc5_ != -1)
            {
               if(!this.line_list[_loc5_].visible)
               {
                  this.line_list[_loc5_].visible = true;
               }
               else
               {
                  _loc2_ = true;
               }
            }
            _loc3_++;
         }
         if(!_loc2_ && _loc1_ == 13)
         {
            this.hasDrawComplete = true;
            ColorFilter.setGrayscale(this.buyPassBtn);
            this.buyPassBtn.mouseEnabled = false;
            ColorFilter.setGrayscale(this.resetBtn);
            this.resetBtn.mouseEnabled = false;
            if(this.fight6v6_state == 0)
            {
               this.centerNpcId = this.NPC6V6_ID;
            }
            else
            {
               this.centerNpcId = this.NPCBOSS_ID;
            }
            this.createCenterNpc();
         }
         else
         {
            this.createLoopNpc();
         }
      }
      
      private function createLoopNpc() : void
      {
         var _loc2_:Mobile = null;
         this.loopNpc = new Vector.<Mobile>();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = new Mobile();
            _loc2_.mouseChildren = false;
            _loc2_.buttonMode = true;
            _loc2_.resourceUrl = URLUtil.getNpcSwf(this.LOOPNPC_ID[_loc1_]);
            _loc2_.addEventListener(MouseEvent.CLICK,this.toLoopFight);
            MobileManager.addMobile(_loc2_,MobileType.NPC);
            this.loopNpc.push(_loc2_);
            this.loopNpc[_loc1_].x = this.LOOPNPC_SEAT[_loc1_].x;
            this.loopNpc[_loc1_].y = this.LOOPNPC_SEAT[_loc1_].y;
            _loc1_++;
         }
      }
      
      private function toLoopFight(param1:MouseEvent) : void
      {
         if(this.hasDrawComplete)
         {
            AlertManager.showAlert("你已经成功绘制六星芒阵,去挑战环阵中心的精灵吧！");
            return;
         }
         if(this.fightloop_state.length >= 13)
         {
            AlertManager.showAlert("你绘制六星芒阵失败,点击确定重置之后再进行挑战!",this.toReset);
            return;
         }
         var _loc2_:int = this.loopNpc.indexOf(param1.target);
         FightManager.startFightWithWild(this.FIGHTLOOP_ID[_loc2_]);
      }
      
      private function toReset() : void
      {
         SwapManager.swapItem(this.RESET_SWAP_ID,1,this.swapComplete);
      }
      
      private function swapComplete(param1:IDataInput) : void
      {
         this.hideLine();
         this.fightloop_state = [];
      }
      
      private function hideLine() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 15)
         {
            this.line_list[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function createCenterNpc() : void
      {
         var _loc1_:int = 0;
         if(Boolean(this.loopNpc) && this.loopNpc.length == 6)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               this.loopNpc[_loc1_].visible = false;
               _loc1_++;
            }
         }
         this.centerNpc = new Mobile();
         this.centerNpc.buttonMode = true;
         this.centerNpc.resourceUrl = URLUtil.getNpcSwf(this.centerNpcId);
         this.centerNpc.x = 420;
         this.centerNpc.y = 350;
         MobileManager.addMobile(this.centerNpc,MobileType.NPC);
         this.centerNpc.addEventListener(MouseEvent.CLICK,this.toFight);
         this.resetBtn.visible = false;
         this.eftMc = null;
         if(this.isBuyPass || this.FIGHTLOOP_ID.indexOf(FightManager.getPositionIndex()) != -1)
         {
            this.centerNpc.visible = false;
            this.eftMc = this.show6v6Eft;
         }
         if(FightManager.getPositionIndex() == this.FIGHT6V6_ID && FightManager.isJustWinFight())
         {
            this.centerNpc.visible = false;
            this.eftMc = this.showBossEft;
         }
         if(this.eftMc)
         {
            this.playEft();
         }
      }
      
      private function playEft() : void
      {
         this.map_model.content.addChild(this.eftMc);
         MovieClipUtil.playMc(this.eftMc,1,this.eftMc.totalFrames,function():void
         {
            var _loc1_:int = 0;
            DisplayObjectUtil.removeFromParent(eftMc);
            eftMc.stop();
            centerNpc.visible = true;
            if(eftMc == showBossEft)
            {
               _loc1_ = VipManager.vipInfo.isVip() ? 2 : 1;
               if(fightboss_state < _loc1_)
               {
                  checkFightTarget();
               }
            }
         },true);
      }
      
      private function checkFightTarget() : void
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc1_.fullYear == 2013 && _loc1_.month == 7 && _loc1_.date >= 16 && _loc1_.date <= 29)
         {
            FightManager.startFightWithBoss(566);
         }
         else
         {
            FightManager.startFightWithBoss(this.FIGHTBOSS_ID);
         }
      }
      
      private function checkPetLevl() : Boolean
      {
         var _loc1_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].level < 100)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         if(!this.checkPetLevl())
         {
            AlertManager.showAlert("必须精灵背包精灵平均等级为100级才能挑战哦！");
            return;
         }
         var _loc2_:int = VipManager.vipInfo.isVip() ? 2 : 1;
         if(this.centerNpcId == this.NPCBOSS_ID)
         {
            if(this.fightboss_state < _loc2_)
            {
               this.checkFightTarget();
            }
            else
            {
               AlertManager.showAlert("你最多可以挑战" + _loc2_ + "次，明天再来吧");
            }
         }
         else if(this.fightboss_state < _loc2_)
         {
            FightManager.startFightWithBoss(this.FIGHT6V6_ID);
         }
         else
         {
            AlertManager.showAlert("你最多可以挑战" + _loc2_ + "次，你已经挑战了" + _loc2_ + "次,明天再来吧！");
         }
      }
   }
}
