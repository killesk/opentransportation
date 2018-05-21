import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Job } from './job';
import { Jobs } from './mock.jobs';
import { MessageService } from './message.service';

@Injectable({
  providedIn: 'root'
})

export class JobService {
  private jobsUrl = 'http://localhost:8082/api/job';  

  constructor(private http: HttpClient,
    private messageService: MessageService) { }

  getJobs(): Observable<Job[]> {
    this.messageService.add('JobService: fetched jobs called');
    return this.http.get<Job[]>(this.jobsUrl)
  }

  getJob(job_id: number): Observable<Job> {
    this.messageService.add(`JobService: fetched Job called id=${job_id}`);
    return this.http.get<Job>(this.jobsUrl + `/${job_id}`)
  }

}
