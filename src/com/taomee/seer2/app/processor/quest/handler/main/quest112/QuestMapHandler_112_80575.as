package com.taomee.seer2.app.processor.quest.handler.main.quest112
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.UILoader;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_112_80575 extends QuestMapHandler
   {
      
      public static var _allRight:Boolean = true;
       
      
      private var mv:MovieClip;
      
      private var _npc:MovieClip;
      
      private var _npcTalkContainer:MovieClip;
      
      private var _npcTalkContent:MovieClip;
      
      private var _npcTalkContentIndex:int;
      
      private var _npcTalkBtn:SimpleButton;
      
      private var _npcTalkBtnRightIndex:int;
      
      private var _npcTalkBtnIndex:int;
      
      private var index:int;
      
      public function QuestMapHandler_112_80575(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         SceneManager.active.mapModel.content["mv2"].visible = false;
         SceneManager.active.mapModel.content["mv3"].visible = false;
         SceneManager.active.mapModel.content["badi"].addEventListener(MouseEvent.CLICK,this.onBadiClick);
         if(!QuestManager.isAccepted(112))
         {
            QuestManager.accept(_quest.id);
         }
      }
      
      private function onBadiClick(param1:* = null) : void
      {
         this.initStep0();
      }
      
      private function initStep0() : void
      {
         var dialog1:Array = null;
         var dialog0:Array = [[400,"小赛尔",[[0,"巴蒂，现在设施怎么样了？"]],["……"]],[10,"巴蒂",[[0,"一切正常，量子计算机已经能为设施提供运算了。"]],["那真是太好了。"]],[400,"小赛尔",[[0,"巴蒂，你还好吧？"]],["……"]],[10,"巴蒂",[[0,"当然还好！我现在就给你们看看我在旧资料室的发现！"]],["是关于斯坦因的？"]],[11,"多罗",[[0,"太好了！有什么秘密啊八卦啊就交给我吧！"]],[" 这不是重点……"]],[10,"巴蒂",[[0,"笨啦！我去旧的资料室获得了飞船老电脑里的任务记录！"]],["记录里怎么说？"]],[10,"巴蒂",[[0,"记录的内容，与云海藏书相吻合，但是却与量子计算机里的记录不同。我在想，正是因为旧资料室的那台老电脑拥有和云海藏书一样的【封闭性】，所以才免于被篡改。"]],["巴蒂你真是个天才！"]],[10,"巴蒂",[[0,"那是当然！斯坦因能找到真相，我也可以！但是话说回来，我们向娜威拉提到了他，对他来说这有可能很危险。"]],["是的。"]],[400,"小赛尔",[[0,"我想，既然斯坦因选择了为我们提供帮助，那么他一定会料到这些吧，他一定知道这个行为可能暴露他的一些信息，但是他还是这样去做了。"]],["他应该是在冒着风险帮助我们吧。"]],[10,"巴蒂",[[0,"先别急着下定义啊队长，斯坦因这个人计谋多端，谁知道他想干什么？我们只管做好眼前的事就好！"]],["（聪明的巴蒂似乎对斯坦因其人心存芥蒂啊）"]],[11,"多罗",[[0,"那个，巴蒂，接下来该怎么办？"]],["……"]]];
         dialog1 = [[10,"巴蒂",[[0,"（抬头）这个设备的调试装置在这里吧，我来试试。"]],["看起来很认真啊。"]],[11,"多罗",[[0,"巴……巴蒂，这个东西现在怎么样了？我已经等不及要看记忆了！"]],["莫急莫急……"]],[10,"巴蒂",[[0,"运算已经就绪了，如果加上云海藏书里的正确记载进行诱导，那么记忆将会从断开之处以正确的方式重新连接在一起，从而推演出正确的记忆。"]],["这就是我们所要的真相了！"]],[10,"巴蒂",[[0,"接下来，如果我没猜错的话，这些思维数据会形成相对客观的画面，就像……把过去重新构建。"]],["来自无数个个体的记忆而形成的，是怎样的画面啊。"]],[400,"赛尔",[[0,"是这样的，那么从这个画面里，我们就能清楚地发现记忆的问题了。"]],["……"]],[400,"赛尔",[[0,"那么，我们各司其职吧。多罗，帮助巴蒂调试设备，我来导入云海藏书的记载。"]],["终于，离真相仅此一步！!"]]];
         NpcDialog.showDialogs(dialog0,function():void
         {
            mv = SceneManager.active.mapModel.content["mv2"];
            NpcDialog.showDialogs(dialog1,function():void
            {
               mv.visible = true;
               MovieClipUtil.playMc(mv,2,mv.totalFrames,function():void
               {
                  mv.visible = false;
                  select();
               });
            });
         });
      }
      
      public function select() : void
      {
         this._npcTalkBtn = UIManager.getButton("UI_NpcTalkBtn");
         this._npcTalkBtn.x = 790;
         this._npcTalkBtn.y = 522;
         UILoader.load(URLUtil.getQuestAnimation("112/npcTalk_0"),LoadType.SWF,this.onLoadNpcTalkComplete);
      }
      
      private function onLoadNpcTalkComplete(param1:ContentInfo) : void
      {
         this._npcTalkContainer = param1.content as MovieClip;
         LayerManager.focusOnTopLayer();
         LayerManager.topLayer.addChild(this._npcTalkContainer);
         this._npcTalkContentIndex = 1;
         this.playNpcTalk();
      }
      
      private function playNpcTalk() : void
      {
         var dialog2:Array = null;
         dialog2 = [[10,"巴蒂",[[0,"好了，大功告成！这玩意终于可以用了！斯坦因的考验，我解决了！"]],["很有成就感啊！"]],[11,"多罗",[[0,"终于能看见失去的记忆了！我要好好找找……有没有落下什么东西…… "]],["遗落的东西，终究会被找回的。"]],[400,"赛尔",[[0,"今天，记忆的门扉终于开启，我们将继续前行，向着失落的真相，向着心中的希望，向着……我们的未来！"]],["风刃氏族，我们回来了。"]]];
         if(this._npcTalkContentIndex == 4)
         {
            DisplayObjectUtil.removeFromParent(this._npcTalkContainer);
            LayerManager.resetOperation();
            this.mv = SceneManager.active.mapModel.content["mv3"];
            this.mv.visible = true;
            MovieClipUtil.playMc(this.mv,2,this.mv.totalFrames,function():void
            {
               mv.visible = false;
               NpcDialog.showDialogs(dialog2,function():void
               {
                  QuestManager.completeStep(questID,1);
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
            });
         }
         else
         {
            switch(this._npcTalkContentIndex)
            {
               case 1:
                  this._npcTalkBtnRightIndex = 1;
                  break;
               case 2:
                  this._npcTalkBtnRightIndex = 3;
                  break;
               case 3:
                  this._npcTalkBtnRightIndex = 2;
            }
            MovieClipUtil.getChildList(this._npcTalkContainer,this._npcTalkContentIndex,[0],function(param1:Vector.<DisplayObject>):void
            {
               var children:Vector.<DisplayObject> = param1;
               _npcTalkContent = children[0] as MovieClip;
               MovieClipUtil.playMc(_npcTalkContent,1,"choose",function():void
               {
                  playNpcChoose(_npcTalkContent);
               });
            });
         }
      }
      
      private function playNpcChoose(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         MovieClipUtil.getChildList(mc,"choose",["btn1","btn2","btn3"],function(param1:Vector.<DisplayObject>):void
         {
            var btn1:SimpleButton = null;
            var btn2:SimpleButton = null;
            var btn3:SimpleButton = null;
            var onClickBtn:Function = null;
            var children:Vector.<DisplayObject> = param1;
            onClickBtn = function(param1:MouseEvent):void
            {
               var evt:MouseEvent = param1;
               btn1.removeEventListener(MouseEvent.CLICK,onClickBtn);
               btn2.removeEventListener(MouseEvent.CLICK,onClickBtn);
               btn3.removeEventListener(MouseEvent.CLICK,onClickBtn);
               _npcTalkBtnIndex = int(evt.currentTarget.name.slice(3));
               index = _npcTalkBtnRightIndex == _npcTalkBtnIndex ? 1 : 2;
               MovieClipUtil.playMc(mc,"start" + index,"mid" + index,function():void
               {
                  LayerManager.topLayer.addChild(_npcTalkBtn);
                  _npcTalkBtn.addEventListener(MouseEvent.CLICK,onClickNpcBtn1);
               });
            };
            btn1 = children[0] as SimpleButton;
            btn2 = children[1] as SimpleButton;
            btn3 = children[2] as SimpleButton;
            btn1.addEventListener(MouseEvent.CLICK,onClickBtn);
            btn2.addEventListener(MouseEvent.CLICK,onClickBtn);
            btn3.addEventListener(MouseEvent.CLICK,onClickBtn);
         });
      }
      
      private function onClickNpcBtn1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         DisplayObjectUtil.removeFromParent(this._npcTalkBtn);
         this._npcTalkBtn.removeEventListener(MouseEvent.CLICK,this.onClickNpcBtn1);
         MovieClipUtil.playMc(this._npcTalkContent,"mid" + this.index,"end" + this.index,function():void
         {
            if(_npcTalkBtnIndex == _npcTalkBtnRightIndex)
            {
               ++_npcTalkContentIndex;
               playNpcTalk();
            }
            else
            {
               _allRight = false;
               playNpcTalk();
            }
         });
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
