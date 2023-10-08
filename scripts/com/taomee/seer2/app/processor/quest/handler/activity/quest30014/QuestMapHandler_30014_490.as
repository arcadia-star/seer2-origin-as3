package com.taomee.seer2.app.processor.quest.handler.activity.quest30014
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.module.Module;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.module.ModuleProxy;
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30014_490 extends QuestMapHandler
   {
      
      public static const ABOUT_EETS:int = 1;
      
      public static const BLACK_EYE:int = 2;
      
      public static const WHO_RICHEST:int = 3;
      
      public static const WHO_DIRTY:int = 4;
      
      public static const ASK_ANSWER:int = 4;
       
      
      private var _npcDefinition:NpcDefinition;
      
      private var _etesStoryModule:Module;
      
      private var _storyIndex:int;
      
      private var _pkMcNpc:MovieClip;
      
      private var _pkMcMe:MovieClip;
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_30014_490(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) || !QuestManager.isStepComplete(_quest.id,1))
         {
            this.createTemporaryNpc();
         }
      }
      
      private function createTemporaryNpc() : void
      {
         this._npc = _processor.resLib.getMovieClip("ScampSjt_30014");
         this._npc.buttonMode = true;
         _processor.mapModel.front.addChild(this._npc);
         this._npc.addEventListener(MouseEvent.CLICK,this.hitNpcHandler);
      }
      
      private function hitNpcHandler(param1:MouseEvent) : void
      {
         var _loc2_:XML = new XML("<dialog npcId=\"495\" npcName=\"沙吉塔流氓版\" transport=\"\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[天灵灵地灵灵，太上老君来显灵！有什么来咨询魔吉塔呀！不过你要付出代价！]]></node>" + "<reply action=\"close\" params=\"30014_490\"><![CDATA[伊特家族齐登场]]></reply>" + "<reply action=\"close\" ><![CDATA[我一会再来]]></reply>" + "</branch>" + "</dialog>");
         var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
         DialogPanel.showForCommon(_loc3_);
         DialogPanel.addCloseEventListener(this.initAccept);
      }
      
      private function initAccept(param1:DialogCloseEvent) : void
      {
         DialogPanel.removeCloseEventListener(this.initAccept);
         ActorManager.showRemoteActor = false;
         if(QuestManager.isAccepted(_quest.id))
         {
            this.acceptHandler(null);
         }
         else if(param1.params == "30014_490")
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.acceptHandler);
            QuestManager.accept(_quest.id);
         }
      }
      
      private function acceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.acceptHandler);
         this.showEtesPanel();
      }
      
      private function showEtesPanel() : void
      {
         var _loc1_:ModuleProxy = ModuleManager.getModule("EtesStoryPanel");
         if(!_loc1_)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("EtesStoryPanel"),"正在打开沙吉塔咨询面板...",this.callBack);
         }
         else
         {
            _loc1_.show();
         }
      }
      
      private function playAnswerDialog(param1:Boolean = true) : void
      {
         var _loc2_:int = 1;
         var _loc3_:Mobile = ActorManager.getActor();
         if(!this._pkMcMe)
         {
            this._pkMcMe = _processor.resLib.getMovieClip("PkVsNpc_30014");
            this._pkMcNpc = _processor.resLib.getMovieClip("Hammer_30014");
            this._pkMcNpc.buttonMode = true;
            this._pkMcMe.buttonMode = true;
            _loc2_ = 1;
            while(_loc2_ < 4)
            {
               (this._pkMcMe["p" + _loc2_] as DisplayObject).addEventListener(MouseEvent.CLICK,this.judgeRightOrWrong);
               _loc2_++;
            }
         }
         _loc2_ = 1;
         while(_loc2_ < 4)
         {
            (this._pkMcMe["p" + _loc2_] as MovieClip).gotoAndStop("normal");
            _loc2_++;
         }
         this._pkMcMe.visible = param1;
         this._pkMcNpc.visible = param1;
         _processor.mapModel.front.addChild(this._pkMcMe);
         this._npc.addChild(this._pkMcNpc);
         this._pkMcNpc.gotoAndStop("normal");
         (this._pkMcNpc["normalMc"] as MovieClip).play();
         this._pkMcMe.x = 349.55;
         this._pkMcMe.y = 383;
         this._pkMcNpc.x = 450;
         this._pkMcNpc.y = 300;
         (this._npc["mark"] as MovieClip).visible = !param1;
         this._npc.mouseChildren = !param1;
         this._npc.mouseEnabled = !param1;
      }
      
      private function judgeRightOrWrong(param1:MouseEvent) : void
      {
         var data:XML = null;
         var dialogDefinition:DialogDefinition = null;
         var event:MouseEvent = param1;
         var i:int = 1;
         while(i < 4)
         {
            (this._pkMcMe["p" + i] as MovieClip).gotoAndStop("normal");
            i++;
         }
         (event.currentTarget as MovieClip).gotoAndStop("light");
         this._pkMcNpc.gotoAndStop("light");
         if(event.currentTarget == this._pkMcMe["p2"])
         {
            data = new XML("<dialog npcId=\"495\" npcName=\"沙吉塔流氓版\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[咦！奇怪了！你怎么知道我是出拳头呢？咦……我记得我好像每次都是拳头?]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[(明明只会出拳头)]]></reply></branch>" + "</dialog>");
            dialogDefinition = new DialogDefinition(data);
            DialogPanel.showForCommon(dialogDefinition,function():void
            {
               showDialogByIndex(_storyIndex);
               playAnswerDialog(false);
            });
         }
         else
         {
            data = new XML("<dialog npcId=\"495\" npcName=\"沙吉塔流氓版\" transport=\"\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[嗨……你还要继续咨询问题吗？我们继续石头剪刀布啊？]]></node>" + "<reply action=\"close\"><![CDATA[(来就来！怕你啊！)]]></reply>" + "</branch>" + "</dialog>");
            dialogDefinition = new DialogDefinition(data);
            DialogPanel.showForCommon(dialogDefinition,function():void
            {
               playAnswerDialog(true);
            });
         }
      }
      
      private function playEtesMovie() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30014_0"),4,[[1,0]],function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Complete);
            QuestManager.completeStep(_quest.id,1);
         });
      }
      
      private function onStep1Complete(param1:Event) : void
      {
         var npcId:int;
         var event:Event = param1;
         ActorManager.showRemoteActor = true;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         npcId = NpcUtil.getSeerNpcId();
         NpcDialog.show(npcId,"我",[[1,"不行！我得到处去找找伊特家族成员......（飞伊特和风伊特似乎在空港)"]],["（快去那里看看）"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,770);
         }]);
      }
      
      public function callBack(param1:int) : void
      {
         this._storyIndex = param1;
         this.startAnswerDialog();
      }
      
      private function startAnswerDialog() : void
      {
         var data:XML = new XML("<dialog npcId=\"495\" npcName=\"沙吉塔流氓版\" transport=\"\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[喂喂喂！老规矩！石头剪刀布！准备好了没？]]></node>" + "<reply action=\"close\"><![CDATA[准备好了（点击魔砂塔）]]></reply>" + "</branch>" + "</dialog>");
         var dialogDefinition:DialogDefinition = new DialogDefinition(data);
         DialogPanel.showForCommon(dialogDefinition,function():void
         {
            playAnswerDialog(true);
         });
      }
      
      private function showDialogByIndex(param1:int) : void
      {
         var _loc2_:XML = null;
         var _loc3_:DialogDefinition = null;
         switch(param1)
         {
            case ABOUT_EETS:
               this.playEtesMovie();
               break;
            case BLACK_EYE:
               _loc2_ = new XML("<dialog npcId=\"495\" npcName=\"沙吉塔流氓版\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[你好八卦！！你没发现“伦家”每次都只出拳头吗？我是猜拳输了被人家画在脸上的啦！]]></node>" + "<reply action=\"close\"><![CDATA[哈哈哈哈……囧的答案！]]></reply></branch>" + "</dialog>");
               break;
            case WHO_RICHEST:
               _loc2_ = new XML("<dialog npcId=\"495\" npcName=\"沙吉塔流氓版\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[汪总管才是最有钱的！出了名的周扒皮！但是不喜欢露财……嘘！]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[收个米共饲料都这么有钱！]]></reply></branch>" + "</dialog>");
               break;
            case WHO_DIRTY:
               _loc2_ = new XML("<dialog npcId=\"495\" npcName=\"沙吉塔流氓版\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[大板牙上完洗手间从不洗手！你说谁最不讲卫生呢？啧啧……还总喜欢把手伸进嘴巴……恶心的家伙！]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[大板牙啊大板牙！]]></reply></branch>" + "</dialog>");
         }
         if(_loc2_)
         {
            _loc3_ = new DialogDefinition(_loc2_);
            DialogPanel.showForCommon(_loc3_);
         }
      }
   }
}
