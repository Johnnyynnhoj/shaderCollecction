using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class lineRenderer : MonoBehaviour
{
    public GameObject point;
    float intervel = 5;
    Camera cam;
    LineRenderer _lineRenderer;
    int pointNumber = 0;
    bool oneDraw = true; 

    // Start is called before the first frame update
    void Start()
    {
        cam = GameObject.Find("Main Camera").GetComponent<Camera>();
        _lineRenderer = gameObject.GetComponent<LineRenderer>();
        _lineRenderer.positionCount =0;
        //lineRenderer.positionCount = 300;
    }

    // Update is called once per frame
    void Update()
    {
        intervel -= 1f; 
      
        drawLine();


        if (Input.GetKeyDown(KeyCode.D))
        {
            Destroy(this.gameObject);
        }

    }

    void drawLine()
    {
        if (Input.GetKey(KeyCode.Mouse0)&& intervel < 0 && oneDraw == true)
        {
            _lineRenderer.positionCount = pointNumber+1;

            //Instantiate(point, cam.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, 20)), transform.rotation);
            _lineRenderer.SetPosition(pointNumber, cam.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, 20)));
            pointNumber += 1;
           

            intervel = 5;

        }

        

        if (Input.GetKeyUp(KeyCode.Mouse0))
        {
            oneDraw = false;
        }



    }
}
