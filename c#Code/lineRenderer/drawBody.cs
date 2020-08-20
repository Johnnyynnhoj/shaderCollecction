using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class drawBody : MonoBehaviour
{

    Camera cam;

    public GameObject lineRendererSystem; 
    // Start is called before the first frame update
    void Start()
    {
        cam = GameObject.Find("Main Camera").GetComponent<Camera>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Mouse0))
        {
            Instantiate(lineRendererSystem, cam.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, 20)), transform.rotation);
        }
    }

    private void OnMouseDown()
    {
        Instantiate(lineRendererSystem, cam.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, 20)), transform.rotation);
    }

    
}
