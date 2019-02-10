
import * as ___wml from '../../src';




export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.widget(Html, {html : { 'id' : ___context.id  } ,wml : {  } }, [___wml.domify((___context.check  ()) ? a : b ) ], ___view);

       }

     }

