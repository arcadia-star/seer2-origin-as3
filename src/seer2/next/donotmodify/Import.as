package seer2.next.donotmodify
{
import flashx.textLayout.compose.ISWFContext;
import mx.core.IFlexModule;
import mx.core.IFlexModuleFactory;
import mx.core.RSLData;
import mx.core.Singleton;
import mx.resources.ResourceBundle;

public class Import
{
    public function Import()
    {
        var ignore = [ISWFContext, IFlexModule, IFlexModuleFactory, RSLData, Singleton, ResourceBundle];
    }
}
}
