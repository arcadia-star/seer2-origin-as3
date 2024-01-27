package org.taomee.bean {
public class BaseBean {


    public function BaseBean() {
        super();
    }

    public function start():void {
    }

    protected function finish():void {
        BeanManager.initClasses();
    }
}
}
