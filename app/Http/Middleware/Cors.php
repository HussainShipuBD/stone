<?php

namespace App\Http\Middleware;

use Closure;

class Cors
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    // public function handle($request, Closure $next)
    // {
    //     return $next($request)
    //     ->header('Access-Control-Allow-Origin',"*")
    //     ->header('Access-Control-Allow-Methods',"PUT,POST,DELETE,GET,OPTIONS")
    //     ->header('Access-Control-Max-Age',600)
    //     ->header('Access-Control-Allow-Headers',"Origin,Accept,Authorization,Content-Type,X-PINGARUNER,X-Request-With");
    //  }

    public function handle($request, Closure $next)
        {
            header("Access-Control-Allow-Origin: *");
            //ALLOW OPTIONS METHOD
            $headers = [
                'Access-Control-Allow-Methods' => 'POST,GET,OPTIONS,PUT,DELETE',
                'Access-Control-Allow-Headers' => 'Content-Type,Origin, Authorization',
            ];

            if ($request->getMethod() == "OPTIONS"){
                //The client-side application can set only headers allowed in Access-Control-Allow-Headers
                return response()->json('OK',200,$headers);
            }
            $response = $next($request);
            foreach ($headers as $key => $value) {
                $response->header($key, $value);
            }
            return $response;

        }
}
