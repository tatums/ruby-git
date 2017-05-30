import { Component } from '@angular/core'
import template from './index.html'

@Component({
  selector: 'my-app',
  template: template,
})

export class AppComponent {
  name = 'Angular'

  constructor() {
    this.message = "Yea! This is cool!"
  }

}
