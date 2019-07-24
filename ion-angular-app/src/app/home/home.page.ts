import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  links;
  loading = false;
  text = '';

  constructor(private http: HttpClient) {}

  handleSubmit(evt) {
    evt.preventDefault();

    this.loading = true;

    this.http.post(
      'http://localhost:5000/fireship-lessons/us-central1/scraper',
      JSON.stringify({ text: this.text })
    )
    .subscribe(res => {
      this.links = res;
      this.loading = false;
    });


  }

  handleChange(evt) {
    this.text = evt.target.value;
  }

}
