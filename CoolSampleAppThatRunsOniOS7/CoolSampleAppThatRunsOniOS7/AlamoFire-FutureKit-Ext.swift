//
//  AlamoFire-FutureKit-Ext.swift
//  CoolSampleAppThatRunsOniOS7
//
//  Created by Michael Gray on 4/25/15.
//  Copyright (c) 2015 Michael Gray. All rights reserved.
//

import Foundation


extension Request {
    
    
    func future<T>(executor : Executor = .Async, serializer: Serializer) -> Future<T> {
        let p = Promise<T> { (cancelToken) -> Void in
            self.cancel()
        }
        self.response(queue: executor.underlyingQueue, serializer: serializer)  { (request, response, data, error) -> Void in
            if let e = error {
                // check this error for cancellation.
                if (e.domain == NSURLErrorDomain) && (e.code == NSURLErrorCancelled) {
                    p.completeWithCancel()
                }
                else {
                    p.completeWithFail(e)
                }
            }
            else if let d = data as? T {
                p.completeWithSuccess(d)
            }
            else {
                p.completeWithFail("No data returned response: \(response)")
            }
        }
        return p.future
        
    }

    func futureJSON(options: NSJSONReadingOptions = .AllowFragments) -> Future<AnyObject> {
        return future(serializer:Request.JSONResponseSerializer(options: options))
    }

    func futureString(encoding: NSStringEncoding? = nil) -> Future<String> {
        return future(serializer:Request.stringResponseSerializer(encoding: encoding))
    }
    func futurePropertyList(options: NSPropertyListReadOptions = 0) -> Future<AnyObject> {
        return future(serializer:Request.propertyListResponseSerializer(options: options))
    }

    
}
 