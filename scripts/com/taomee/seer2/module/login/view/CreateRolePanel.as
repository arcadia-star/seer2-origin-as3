package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.net.Connection;
   import com.taomee.seer2.module.login.net.MessageEvent;
   import com.taomee.seer2.module.login.util.ColorFilter;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import com.taomee.seer2.module.login.util.StringUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class CreateRolePanel extends Sprite
   {
      
      public static const SELECT_SEX:String = "selectSex";
      
      public static const SELECT_COLOR:String = "selectColor";
      
      public static const SELECT_NAME:String = "selectName";
      
      private static const NICK_DIRTY_TIPS:String = "你输入的昵称不合法!";
       
      
      private var _domain:ApplicationDomain;
      
      private var _loginAgent:LoginAgent;
      
      private var _color:int;
      
      private var _sex:int;
      
      private var _sexPage:com.taomee.seer2.module.login.view.CreateSexPage;
      
      private var _colorPage:com.taomee.seer2.module.login.view.CreateColorPage;
      
      private var _namePage:com.taomee.seer2.module.login.view.CreateNamePage;
      
      private var _captenMC:MovieClip;
      
      private var _mainMC:MovieClip;
      
      private var _actorMC:MovieClip;
      
      private var _okBtn:SimpleButton;
      
      private var _actorIndex:int;
      
      private var _petIndex:int;
      
      public function CreateRolePanel(param1:LoginAgent)
      {
         super();
         this._loginAgent = param1;
         LoaderAgent.addEventListener("createRole",this.onLoadCreateRolePage);
         LoaderAgent.loadDomain("createRole");
      }
      
      private function onLoadCreateRolePage(param1:Event) : void
      {
         LoaderAgent.removeEventListner("createRole",this.onLoadCreateRolePage);
         this._domain = LoaderAgent.getDomain("createRole");
         this._actorIndex = -1;
         this._petIndex = 0;
         this._mainMC = DomainUtil.getMovieClip("mainMC",this._domain);
         this._actorMC = this._mainMC["actorMC"];
         this._okBtn = this._mainMC["okBtn"];
         addChild(this._mainMC);
         LoginStatistics.newSendNovice("_newtrans_",this._loginAgent.mainServerLoginInfo.account.toString(),"fLoadLoginSucc","前端成功加载创建角色界面");
         LoginStatistics.newSendNovice("新手引导tyler版",this._loginAgent.mainServerLoginInfo.account.toString(),"2014上半年版新手引导tyler版","进入选择角色的页面的");
         this.init();
      }
      
      private function updateBtn(param1:int) : void
      {
         if(param1 == 0)
         {
            this._actorMC["actorBtn0"].removeEventListener(MouseEvent.CLICK,this.onClick0);
            this._actorMC["actorBtn0"].addEventListener(MouseEvent.CLICK,this.onClick0);
            this._actorIndex = 1;
         }
         else if(param1 == 1)
         {
            this._actorMC["actorBtn1"].removeEventListener(MouseEvent.CLICK,this.onClick1);
            this._actorMC["actorBtn1"].addEventListener(MouseEvent.CLICK,this.onClick1);
            this._actorIndex = 0;
         }
         LoginStatistics.newSendNovice("新手引导tyler版",this._loginAgent.mainServerLoginInfo.account.toString(),"2014上半年版新手引导tyler版","完成选择角色的");
      }
      
      private function onClick0(param1:MouseEvent) : void
      {
         this._actorMC["actorBtn0"].removeEventListener(MouseEvent.CLICK,this.onClick0);
         this._actorMC.gotoAndPlay(2);
         this._actorMC.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         this._actorMC.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function onFrame(param1:Event) : void
      {
         if(this._actorMC.currentFrame == 20 && Boolean(this._actorMC["actorBtn1"]))
         {
            this._actorMC.removeEventListener(Event.ENTER_FRAME,this.onFrame);
            this.updateBtn(1);
         }
         else if(this._actorMC.currentFrame == 1 && Boolean(this._actorMC["actorBtn0"]))
         {
            this._actorMC.removeEventListener(Event.ENTER_FRAME,this.onFrame);
            this.updateBtn(0);
         }
         this.checkGo();
      }
      
      private function onClick1(param1:MouseEvent) : void
      {
         this._actorMC["actorBtn1"].removeEventListener(MouseEvent.CLICK,this.onClick1);
         this._actorMC.gotoAndPlay(21);
         this._actorMC.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         this._actorMC.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function init() : void
      {
         this._actorMC.gotoAndStop(20);
         this.updateBtn(1);
         this._okBtn.addEventListener(MouseEvent.CLICK,this.onOk);
         this.showNamePage();
         Connection.addErrorHandler(107,this.onCreateRoleError);
      }
      
      private function onOk(param1:MouseEvent) : void
      {
         this._okBtn.mouseEnabled = false;
         LoginStatistics.sendAccountNovice(LoginStatistics.selectRoleName,this._loginAgent.mainServerLoginInfo.account);
         LoginStatistics.sendNovice(LoginStatistics.selectName,this._loginAgent.mainServerLoginInfo.account);
         var _loc2_:int = 0;
         if(this._actorIndex == 1)
         {
            _loc2_ = 7;
         }
         this._loginAgent.createRole(StringUtil.trim(this._namePage.getNick()),_loc2_,this._actorIndex);
         LoginStatistics.sendAccountNovice("0x10034677",this._loginAgent.mainServerLoginInfo.account);
         LoginStatistics.newSendNovice("_newtrans_",this._loginAgent.mainServerLoginInfo.account.toString(),"fClickStartBtn","前端用户点击开始游戏按钮");
      }
      
      private function showNamePage() : void
      {
         this._namePage = new com.taomee.seer2.module.login.view.CreateNamePage(this._mainMC["nameMC"],this.checkGo);
         this._actorIndex = 0;
         this.checkGo();
      }
      
      private function hideNamePage() : void
      {
         this._namePage.dispose();
         this._namePage = null;
      }
      
      private function checkGo() : void
      {
         if(this._actorIndex != -1 && this._namePage.onNextClick())
         {
            this._okBtn.mouseEnabled = true;
            this._okBtn.filters = [];
         }
         else
         {
            this._okBtn.mouseEnabled = false;
            ColorFilter.setGrayscale(this._okBtn);
         }
      }
      
      private function onCreateRoleError(param1:MessageEvent) : void
      {
         this._loginAgent.close();
         switch(param1.message.statusCode)
         {
            case 6006:
            case 6007:
            case 6008:
               this.showError(NICK_DIRTY_TIPS);
               this.checkGo();
         }
      }
      
      private function showError(param1:String) : void
      {
         this._namePage.showError(param1);
      }
      
      public function dispose() : void
      {
         Connection.removeErrorHandler(107,this.onCreateRoleError);
         this.hideNamePage();
         this._domain = null;
         this._loginAgent = null;
      }
   }
}
