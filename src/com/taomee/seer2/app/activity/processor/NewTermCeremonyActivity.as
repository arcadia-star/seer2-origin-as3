package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.init.LoginInfo;
   import com.taomee.seer2.app.manager.OnlyFlagManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.NumberUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class NewTermCeremonyActivity extends EventDispatcher
   {
      
      public static const SERVER_BUFF_INDEX:int = 1;
      
      public static const SERVER_BUFF_INDEX2:int = 2;
      
      public static const SERVER_BUFF_INDEX3:int = 3;
      
      public static const BEGIN_TIME:Date = new Date(2012,8,1,14,30);
      
      public static const END_TIME:Date = new Date(2012,8,13,23);
      
      public static const XEGG_BEGIN_TIME:Date = new Date(2012,8,15,13,30);
      
      public static const XEGG_END_TIME:Date = new Date(2012,8,15,14);
      
      private static var _isFromPanel:Boolean = false;
      
      private static var _mouseHint:Sprite;
      
      private static var _flag:int = 0;
      
      private static var _index:int;
       
      
      private var _nick:String;
      
      private var _box1:MovieClip;
      
      private var _box2:MovieClip;
      
      private var _box3:MovieClip;
      
      private var _Panel:MovieClip;
      
      private var _resLib:ResourceLibrary;
      
      public function NewTermCeremonyActivity(param1:IEventDispatcher = null)
      {
         super(param1);
         this.init();
         showMouseHint();
      }
      
      public static function set isComeFromPanel(param1:Boolean) : void
      {
         _isFromPanel = param1;
         if(SceneManager.active.mapID == 70)
         {
            showMouseHint();
         }
      }
      
      public static function showMouseHint() : void
      {
         if(_isFromPanel)
         {
            DisplayObjectUtil.removeFromParent(_mouseHint);
            _isFromPanel = false;
            ServerBufferManager.getServerBuffer(ServerBufferType.NEWTERM_BUFF,function(param1:ServerBuffer):void
            {
               var _loc2_:int = param1.readDataAtPostion(SERVER_BUFF_INDEX3);
               if(_loc2_ == 0)
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.NEWTERM_BUFF,SERVER_BUFF_INDEX3,1);
                  DisplayObjectUtil.removeFromParent(_mouseHint);
                  _mouseHint = new MouseClickHintSprite();
                  _mouseHint.x = 590;
                  _mouseHint.y = 100;
                  SceneManager.active.mapModel.front.addChild(_mouseHint);
               }
            });
         }
      }
      
      private static function onSuccess(param1:IDataInput) : void
      {
         _flag = 1;
         var _loc2_:SwapInfo = new SwapInfo(param1,false);
         var _loc3_:String = ItemConfig.getItemName(_loc2_.itemID);
         ServerMessager.addMessage(_loc3_ + "送给你！");
      }
      
      private static function onFailed(param1:*) : void
      {
         _flag = 1;
         NpcDialog.show(515,"塔比丘",[[0,"寡人背包容量有限……礼物都没了啦……下次再带给你？不要急！不要闹！你乖啦！好好读书！下次我给你带更好的礼物好不好~~"]],["好吧！"]);
      }
      
      private function init() : void
      {
         this._nick = LoginInfo.userInfo.nick;
         this.getURL();
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.unitClickHandler);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.dialogShowHandler);
      }
      
      private function dialogShowHandler(param1:DialogPanelEvent) : void
      {
         if(param1.content == 153)
         {
            this.playFullMovie();
         }
      }
      
      private function playFullMovie() : void
      {
         DisplayObjectUtil.removeFromParent(_mouseHint);
         ServerBufferManager.getServerBuffer(ServerBufferType.NEWTERM_BUFF,function(param1:ServerBuffer):void
         {
            var sev:ServerBuffer = param1;
            var flag:int = sev.readDataAtPostion(SERVER_BUFF_INDEX);
            if(flag == 0)
            {
               MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/newTermFullMovie1.swf"),function():void
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.NEWTERM_BUFF,SERVER_BUFF_INDEX,1);
               });
            }
         });
      }
      
      private function unitClickHandler(param1:DialogPanelEvent) : void
      {
         if(param1.content.params == "zhanzhang_texun")
         {
            this.trainPanel();
         }
         else if(param1.content.params == "zhihui_kaoyan")
         {
            this.intelligencePanel();
         }
         else if(param1.content.params == "long_dan")
         {
            this.longdanPanel();
         }
         else if(param1.content.params == "xunlianshi")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("NewTermTrainAwardPanel"),"正在训练师领奖面板...");
         }
         else if(param1.content.params == "AboutXegg")
         {
            this.isHasXegg();
         }
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.unitClickHandler);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.dialogShowHandler);
      }
      
      private function trainPanel() : void
      {
         var _loc1_:XML = new XML("<dialog npcId=\"153\" npcName=\"贾斯汀\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[你好!" + this._nick + "，不知道这个暑假你的精灵训练的怎么样了？就让我和克拉克站长为你的精灵做一次特别训练吧！]]></node>" + "<reply action=\"close\" params=\"kaixue_zizi\"><![CDATA[点击克拉克身旁的装置开始训练]]></reply>" + "<reply action=\"close\" params=\"\"><![CDATA[我不练了，去写作业了]]></reply></branch>" + "</dialog>");
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_CLOSED,this.trainUnitClickHandler);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function trainUnitClickHandler(param1:DialogPanelEvent) : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED,this.trainUnitClickHandler);
         if(param1.content.params == "kaixue_zizi")
         {
            SceneManager.changeScene(SceneType.LOBBY,60);
         }
      }
      
      private function intelligencePanel() : void
      {
         var _loc1_:XML = new XML("<dialog npcId=\"153\" npcName=\"贾斯汀\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[你好！" + this._nick + "，关于赛尔II的知识你掌握了多少？敢不敢让我贾斯汀站长来考验一下？放心，题目不难的，答对有奖。]]></node>" + "<reply action=\"close\" params=\"jinguan_wen\"><![CDATA[好！尽管问！]]></reply>" + "<reply action=\"close\" params=\"wo_hen_ben\"><![CDATA[站长我妈妈说我很笨]]></reply></branch>" + "</dialog>");
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_CLOSED,this.intelligenceUnitClickHandler);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function intelligenceUnitClickHandler(param1:DialogPanelEvent) : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED,this.intelligenceUnitClickHandler);
         if(param1.content.params == "jinguan_wen")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("SeerIIAnswerPanel"),"正在问答面板...");
         }
      }
      
      private function longdanPanel() : void
      {
         var _loc1_:XML = new XML("<dialog npcId=\"153\" npcName=\"贾斯汀\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[终于要送出这份大礼了！X龙蛋会孵化出这个宇宙最为神秘的龙系精灵，非常珍贵，这次我只带来50000个，先领先得!]]></node>" + "<reply action=\"close\" params=\"wo_yao_ling\"><![CDATA[我要领!]]></reply></branch>" + "</dialog>");
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_CLOSED,this.longdanUnitClickHandler);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function longdanUnitClickHandler(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED,this.longdanUnitClickHandler);
         if(event.content.params == "wo_yao_ling")
         {
            if(DateUtil.isInTime(BEGIN_TIME,END_TIME))
            {
               ServerBufferManager.getServerBuffer(ServerBufferType.NEWTERM_BUFF,function(param1:ServerBuffer):void
               {
                  var _loc2_:int = param1.readDataAtPostion(SERVER_BUFF_INDEX2);
                  if(_loc2_ == 0)
                  {
                     SwapManager.swapItem(567,1,getLongdanSuccess,getLongdanFail);
                  }
                  else
                  {
                     isAlreadyGet();
                  }
               });
            }
            else
            {
               this.timeIsNotUp();
            }
         }
      }
      
      private function getLongdanSuccess(param1:*) : void
      {
         new SwapInfo(param1,false);
         ServerBufferManager.updateServerBuffer(ServerBufferType.NEWTERM_BUFF,SERVER_BUFF_INDEX2,1);
         var _loc2_:XML = new XML("<dialog npcId=\"153\" npcName=\"贾斯汀\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[X龙蛋已经放入你的小屋了，快去看看吧。记住，X龙蛋是非常珍贵的，希望你一定要好好培育爱惜它！  ]]></node>" + "<reply action=\"close\" params=\"yes_zhanzhang\"><![CDATA[是！站长！ ]]></reply>" + "<reply action=\"close\" params=\"go_home\"><![CDATA[去小屋看看蛋蛋]]></reply></branch>" + "</dialog>");
         var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_CLOSED,this.getLongdanUnitClickHandler);
         DialogPanel.showForCommon(_loc3_);
      }
      
      private function getLongdanUnitClickHandler(param1:DialogPanelEvent) : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED,this.getLongdanUnitClickHandler);
         if(param1.content.params == "go_home")
         {
            SceneManager.changeScene(SceneType.HOME,ActorManager.actorInfo.id);
         }
      }
      
      private function getLongdanFail(param1:*) : void
      {
         var _loc2_:XML = new XML("<dialog npcId=\"153\" npcName=\"贾斯汀\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[哦，好可惜，你来晚一步，X龙蛋已经领完了。别难过，下次我还会带更棒的礼物给你的。  ]]></node>" + "<reply action=\"close\" params=\"man_teng_teng\"><![CDATA[哎。。。我妈妈总说我慢腾腾的。]]></reply></branch>" + "</dialog>");
         var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_CLOSED,this.beLateUnitClickHandler);
         DialogPanel.showForCommon(_loc3_);
      }
      
      private function beLateUnitClickHandler(param1:DialogPanelEvent) : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED,this.beLateUnitClickHandler);
         if(param1.content.params == "man_teng_teng")
         {
            this.noSadHandler();
         }
      }
      
      private function noSadHandler() : void
      {
         var _loc1_:XML = new XML("<dialog npcId=\"515\" npcName=\"塔比丘\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[插播广告：9月15日（周六）13:30-14:00，站长离开时还会派发一批龙蛋，运送龙蛋的事情当然就交给我啦！ ]]></node>" + "<reply action=\"close\" params=\"very_good\"><![CDATA[太好了！  ]]></reply></branch>" + "</dialog>");
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function isAlreadyGet() : void
      {
         var _loc1_:XML = new XML("<dialog npcId=\"153\" npcName=\"贾斯汀\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[你已经领过喽，每个小赛尔只能领1枚龙蛋哦。 ]]></node>" + "<reply action=\"close\" params=\"ok\"><![CDATA[是！站长！ ]]></reply></branch>" + "</dialog>");
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function timeIsNotUp() : void
      {
         var _loc1_:XML = new XML("<dialog npcId=\"153\" npcName=\"贾斯汀\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[X龙蛋会孵化出这个宇宙最为神秘的龙系精灵，这次我只带来50000个，9月1日14:30开始就可以来我这里领取！ ]]></node>" + "<reply action=\"close\" params=\"ok\"><![CDATA[知道了。    ]]></reply></branch>" + "</dialog>");
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function isHasXegg() : void
      {
         if(DateUtil.isInTime(XEGG_BEGIN_TIME,XEGG_END_TIME))
         {
            this.isCanGetXegg();
         }
         else
         {
            NpcDialog.show(515,"塔比丘",[[0,"咦？你怎么这个时间来领取X龙蛋相关的奖品啊？不是我们约好的时间哦！（9月15日13:30-14:00开放）"]],["好吧！"]);
         }
      }
      
      private function isCanGetXegg() : void
      {
         OnlyFlagManager.RequestFlag(function():void
         {
            var flag:int = OnlyFlagManager.getFlag(486);
            if(flag == 0 && _flag == 0)
            {
               NpcDialog.show(515,"塔比丘",[[0,"来得好不如来得巧！如果你还没有龙蛋，我这里还有几个龙蛋呢！不过你得帮我先算算账，我才能给你！"]],["放马过来吧！（开始算账）","额……我一会再来找你"],[function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("SeerIIAnswerPanelNew"),"正在问答面板...");
                  ModuleManager.addEventListener("SeerIIAnswerPanelNew","answerOK",onDisposePanel);
               }]);
            }
            else
            {
               NpcDialog.show(515,"塔比丘",[[0,"切！少贪心了啦！“伦家”刚才不都依你了嘛！都给你了好不好！下次……下次……下次再带礼物给你吧！"]],["好吧！"]);
            }
         });
      }
      
      private function onDisposePanel(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("SeerIIAnswerPanelNew","answerOK",this.onDisposePanel);
         this.initGuessPanel();
      }
      
      private function initGuessPanel() : void
      {
         this._Panel = this.getRandomMC();
         LayerManager.moduleLayer.addChild(this._Panel);
         MovieClipUtil.playMc(this._Panel,1,this._Panel.totalFrames,function():void
         {
            _box1 = _Panel["box1"] as MovieClip;
            _box2 = _Panel["box2"] as MovieClip;
            _box3 = _Panel["box3"] as MovieClip;
            _box1.buttonMode = true;
            _box2.buttonMode = true;
            _box3.buttonMode = true;
            initEvent();
         });
      }
      
      private function initEvent() : void
      {
         this._box1.addEventListener(MouseEvent.CLICK,this.onOpenBoxHandler);
         this._box2.addEventListener(MouseEvent.CLICK,this.onOpenBoxHandler);
         this._box3.addEventListener(MouseEvent.CLICK,this.onOpenBoxHandler);
      }
      
      private function onOpenBoxHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         var $mc:MovieClip = evt.currentTarget as MovieClip;
         $mc.gotoAndStop(2);
         DisplayUtil.removeForParent(this._Panel);
         if(_index == 1 || _index == 2)
         {
            if(evt.currentTarget == this._box2)
            {
               this.getPrize();
            }
            else
            {
               NpcDialog.show(515,"塔比丘",[[0,"加油加油！差一点点就猜到了！作为一个邮差！我很认真的告诉你！我在训练你的眼力！数量有限！加油啊！"]],["继续！","我要做做准备再来！"],[function():void
               {
                  initGuessPanel();
               }]);
            }
         }
         else if(_index == 3)
         {
            if(evt.currentTarget == this._box3)
            {
               this.getPrize();
            }
            else
            {
               NpcDialog.show(515,"塔比丘",[[0,"加油加油！差一点点就猜到了！作为一个邮差！我很认真的告诉你！我在训练你的眼力！数量有限！加油啊！"]],["继续！","我要做做准备再来！"],[function():void
               {
                  initGuessPanel();
               }]);
            }
         }
      }
      
      private function getPrize() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("xegg/full5"),function():void
         {
            SwapManager.swapItem(584,1,onSuccess,onFailed);
         },false);
      }
      
      private function getURL() : void
      {
         var url:String = String(URLUtil.getActivityAnimation("xegg/guess"));
         var resourceLoader:ResourceLibraryLoader = new ResourceLibraryLoader(url);
         resourceLoader.getLib(function(param1:ResourceLibrary):void
         {
            _resLib = param1;
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return this._resLib.getMovieClip(param1);
         }
         return null;
      }
      
      private function getRandomMC() : MovieClip
      {
         _index = NumberUtil.random(1,3);
         return this.getMovie("mc" + _index);
      }
   }
}
