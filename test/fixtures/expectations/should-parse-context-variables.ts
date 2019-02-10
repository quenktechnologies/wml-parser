
import * as ___wml from '../../src';




export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.widget(Input, {html : { 'name' : ___context.level.name   } ,wml : {  } }, [], ___view);

       }

     }

