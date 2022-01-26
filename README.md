
# Fluidic Pinball - Controlling Flow by Reinforcement Learning

In this repository we attempt to control the flow around three cylinders placed as fluidic pinball setup [[Pastur et al.](https://arxiv.org/pdf/2104.05104.pdf)]. 

# Flow Simulation
<details>
<summary markdown="spawn"> Click to expand! </summary>
  
+ <details>
  <summary markdown="spawn">Singularity Container</summary>
  
  For the simulation setup in OpenFOAM, the base case for the simulation may be found in  `./test_cases/base_case`. For more info see  [here.](https://ml-cfd.com/2020/12/29/running-pytorch-models-in-openfoam-basic-setup-and-examples/)

  To Built the singularity image follow the instruction given [here](https://github.com/AndreWeiner/of_pytorch_docker). The singularity image file (.sif) should be in parent directory.

  This base case is executable with singularity image as,

  `singuarity run of2006-py1.6-cpu.sif ./Allrun ./test_cases/base_case/`

  </details>
  
+ <details>
  <summary markdown="spawn">Flow Setup</summary>
  
  + <details>
    <summary markdown="spawn">Geometry</summary>
  
    The computational domain is formed as explained in [Pastur et al.](https://arxiv.org/abs/2104.05104) The left most cylinder is considered as cylinder A, Top cylinder as cylinder B and Bottom cylinder as cylinder C.
    
    </details>
  
  + <details>
    <summary markdown="spawn"> Meshing </summary> 
    
    Meshing of the computational domain is achieved by the blockMesh functionality in OpenFOAM in which the domain is divided in *N* numbers of hexahedron blocks. The mesh cells are hexahedron. The blockMesh is significantly faster than snappyHexMesh. 
    
    For implementation refer [this](https://github.com/darshan315/fluidic_pinball/blob/main/test_cases/base_case/system/blockMeshDict) file.
  
    </details>
  
  
  + <details>
    <summary markdown="spawn">Boundary Conditions </summary>
  
    The inlet boundary condition is applied to the left, top and bottom sides of the rectangle containing cylinders. The inlet boundary condition is applied for uniform velocity BC. The outlet boundary condition is applied to right side of the rectangle as `ZeroGradient`. The `noSlip` boundary condition is applied to the all cylinders. For more details see [this](https://github.com/darshan315/fluidic_pinball/blob/main/test_cases/base_case/0.org/U), [this](https://github.com/darshan315/fluidic_pinball/blob/main/test_cases/base_case/0.org/p) and [this](https://github.com/darshan315/fluidic_pinball/blob/main/test_cases/base_case/system/blockMeshDict) files.
    </details>
  
  + <details>
    <summary markdown="spawn"> c<sub>L</sub> </summary>
  
    The Reynolds number (<img src="https://latex.codecogs.com/svg.image?\inline&space;Re" title="\inline Re" />) is computed as :
    
    <img src="https://latex.codecogs.com/svg.image?Re&space;=&space;\frac{U_{\infty}D}{\nu}" title="Re = \frac{U_{\infty}D}{\nu}" />
    
    Where, <img src="https://latex.codecogs.com/svg.image?\inline&space;U_{\infty}" title="\inline U_{\infty}" /> is free stream velocity, <img src="https://latex.codecogs.com/svg.image?\inline&space;D" title="\inline D" /> is diameter of cylinder and <img src="https://latex.codecogs.com/svg.image?\inline&space;\nu" title="\inline \nu" /> is kinematic viscosity.
  
    Coefficient of lift (<img src="https://latex.codecogs.com/svg.image?\inline&space;c_L" title="\inline c_L" />) is calculated as :
    
    <img src="https://latex.codecogs.com/svg.image?c_L&space;=&space;\frac{2L}{U^2A}" title="c_L = \frac{2L}{U^2A}" />
  
    Where, <img src="https://latex.codecogs.com/svg.image?\inline&space;L" title="\inline L" /> is lift force. <img src="https://latex.codecogs.com/svg.image?\inline&space;A" title="\inline A" /> is area enclosed by single cylinder. Here <img src="https://latex.codecogs.com/svg.image?A&space;=&space;D&space;\times&space;Z_t" title="A = D \times Z_t" />   where, <img src="https://latex.codecogs.com/svg.image?\inline&space;Z_t" title="\inline Z_t" /> is cell thickness in <img src="https://latex.codecogs.com/svg.image?\inline&space;z" title="\inline z" />-direction as the simulation setup is quasi 2D and containing only one cell in <img src="https://latex.codecogs.com/svg.image?\inline&space;z" title="\inline z" />-direction. 
  
    The <img src="https://latex.codecogs.com/svg.image?\inline&space;c_L" title="\inline c_L" /> is calculated for each individual cylinder. i.e. <img src="https://latex.codecogs.com/svg.image?\inline&space;c_L_{A}" title="\inline c_L_{A}" /> refers to <img src="https://latex.codecogs.com/svg.image?\inline&space;c_L" title="\inline c_L" /> for cylinder A. The results are compared with [Bieker et al.](https://link.springer.com/article/10.1007/s00162-020-00520-4)
  
  
    + <details>
      <summary markdown="spawn">Click to see figure for c<sub>L</sub> of all individual cylinder where, Re = 100. </summary>
    
      ![bieker_100_cl](https://user-images.githubusercontent.com/50383431/147487488-1e4eda65-65f7-495e-8ab0-b08e64387fc4.png)

      </details>
   
    + <details>
      <summary markdown="spawn">Click to see figure for c<sub>L</sub> of all individual cylinder where, Re = 140.  </summary>
    
      ![bieker_140_cl](https://user-images.githubusercontent.com/50383431/147487531-0f772a38-bb50-4285-aad1-b49fe6a5aa2b.png)

      </details>
  
    + <details>
      <summary markdown="spawn">Click to see figure for c<sub>L</sub> of all individual cylinder where, Re = 200.  </summary>
   
      ![bieker_200_cl](https://user-images.githubusercontent.com/50383431/147487541-6365ad71-c9f1-4a24-b7ea-3cd8da09888d.png)

      </details>

  </details>
  
+ <details>
  <summary markdown="spawn">Mesh Dependency study</summary>

  The meshing of domain is achieved by using blockMesh functionality of OpenFOAM. 

  Meshing level (L) for blockmesh is set to specific numbers of cells in all block and the base mesh level is considered as mentioned in `mesh_o2_i2` case. Then, the mesh is refined as 75%L (`mesh_o1_i1`) and 125%L (`mesh_o3_i3`). Where, in 75%L the mesh is 25% coarse and in 125%L the mesh is 25% finer than base mesh. 

  For mesh dependency study, execute the shell file as,
  1. Locally - (./test_cases/mesh_dependency_study/)
  ```
    $ bash local_mesh_dependency_study.sh
  ```
  2. On cluster (./test_cases/mesh_dependency_study/)
  ```
    $ bash cluster_mesh_dependency_study.sh
  ```
 
  The simulations for different mesh will generate in  `./test_case/run/mesh_dependency_study/`.

  To check consider the mean and standard deviation of c<sub>L</sub>, the convergence of mean and standard deviation of mean over the time is plotted and the appropriate time-period is selected to compute mean and standard deviation of c<sub>L</sub>.

  + <details>
    <summary markdown="spawn">Click to see figure for convergence of mean of c<sub>L</sub> (&mu;<sub>c<sub>L</sub></sub>) for mesh-level 125%L</summary>
  
    ![mesh_o3_i3_mean](https://user-images.githubusercontent.com/50383431/147428065-0cbb2296-474f-4372-afa5-39b7790414e2.png)
  
    </details>
  
  + <details>
    <summary markdown="spawn">Click to see figure for convergence of standard deviation of c<sub>L</sub> (&sigma;<sub>c<sub>L</sub></sub>)for mesh-level 125%L</summary>
  
    ![mesh_o3_i3_std](https://user-images.githubusercontent.com/50383431/147429597-e5b33e50-359c-4339-996b-43dcb143119c.png)

    </details>
  
  Result of Mesh dependency study :
  
  + <details>
    <summary markdown="spawn">Click to see figure for mean of c<sub>L</sub> (&mu;<sub>c<sub>L</sub></sub>) on different mesh-levels </summary>
  
    ![mesh_dependency_means](https://user-images.githubusercontent.com/50383431/147491763-c45b9e6d-1acd-45f3-b059-42d9e564313c.png)

    </details>
  
  + <details>
    <summary markdown="spawn">Click to see figure for standard deviation of c<sub>L</sub> (&sigma;<sub>c<sub>L</sub></sub>) on different mesh-levels </summary>
    
    ![mesh_dependency_std](https://user-images.githubusercontent.com/50383431/147491781-393321f0-d7e1-4a3f-be70-d288bb146ce9.png)

    </details>

  <b>Hence, the mesh-level 125%L is considered for the rest of the flow simulations.</b>
  
+ <details>
  <summary markdown="spawn">Flow Simulation on different Reynolds numbers</summary>
  
  For Flow Simulation on different Reynolds number, execute the shell file as,
  
    1. Locally - (`./test_cases/RE_vary/`)
    ```
      $ bash local_different_REs.sh
    ```
    2. On cluster (`./test_cases/RE_vary/`)
    ```
      $ bash cluster_different_REs.sh
    ```
  The Reynolds number is varied as 10, 20, 30, ..., 200.
  + <details>
    <summary markdown="spawn">Click to see figure for mean of c<sub>L</sub> (&mu;<sub>c<sub>L</sub></sub>) on different Reynolds numbers </summary>
  
    ![RE_means](https://user-images.githubusercontent.com/50383431/147584654-2f2daf7d-213b-4a96-9644-93e95d34866d.png)
  
    </details>
  
  + <details>
    <summary markdown="spawn">Click to see figure for standard deviation of c<sub>L</sub> (&sigma;<sub>c<sub>L</sub></sub>) on Reynolds numbers </summary>
   
    ![RE_std](https://user-images.githubusercontent.com/50383431/147584718-d77fd2a5-47b9-4ef7-a019-7cfb1a100418.png)

    </details>
  
  + <details>
    <summary markdown="spawn">Click to see figure for Mean and standard deviation comparisoin with referance by varying Reynolds number. </summary>
     
    Referance can be found [here](https://arxiv.org/pdf/2104.05104.pdf). Where, <img src="https://latex.codecogs.com/svg.image?\inline&space;\Large|\overline{\mu_{c_L}}|" title="\inline \Large|\overline{\mu_{c_L}}|" /> is absoulate value of mean of mean-lift for each cylinder. <img src="https://latex.codecogs.com/svg.image?\inline&space;\sigma_{c_L}" title="\inline \sigma_{c_L}" /> is sum of standard deviation for each cylinder. <img src="https://latex.codecogs.com/svg.image?\inline&space;{c_L}_A" title="\inline {c_L}_A" />, <img src="https://latex.codecogs.com/svg.image?\inline&space;{c_L}_B" title="\inline {c_L}_B" />, and <img src="https://latex.codecogs.com/svg.image?\inline&space;{c_L}_C" title="\inline {c_L}_C" /> represents lift for cylinder A, B and C respectively. <img src="https://latex.codecogs.com/svg.image?\inline&space;\mu_{{c_L}_A}" title="\inline \mu_{{c_L}_A}" />, <img src="https://latex.codecogs.com/svg.image?\inline&space;\mu_{{c_L}_B}" title="\inline \mu_{{c_L}_B}" /> and <img src="https://latex.codecogs.com/svg.image?\inline&space;\mu_{{c_L}_C}" title="\inline \mu_{{c_L}_C}" /> denotes mean of lift over soecified timestep for cylinder A, B and C respectively. <img src="https://latex.codecogs.com/svg.image?\inline&space;\sigma_{{c_L}_A}" title="\inline \sigma_{{c_L}_A}" />, <img src="https://latex.codecogs.com/svg.image?\inline&space;\sigma_{{c_L}_B}" title="\inline \sigma_{{c_L}_B}" />, and <img src="https://latex.codecogs.com/svg.image?\inline&space;\sigma_{{c_L}_C}" title="\inline \sigma_{{c_L}_C}" /> represents standard deviation of lift for cylinder A, B and C respectively.  
  
  
    ![eq1](https://latex.codecogs.com/svg.image?\Large|\overline{\mu_{c_L}}|&space;=&space;\left|\frac{\left(&space;\mu_{{c_L}_A}&space;&plus;\mu_{{c_L}_B}&plus;\mu_{{c_L}_C}&space;\right)}{3}\right|)
  
  
    ![](https://latex.codecogs.com/svg.image?%5CLarge%5Csigma_%7Bc_L%7D%20=%20%5Csigma_%7B%7Bc_L%7D_A%7D&plus;%5Csigma_%7B%7Bc_L%7D_B%7D&plus;%5Csigma_%7B%7Bc_L%7D_C%7D)
   
     ![RE_std_mean_combined](https://user-images.githubusercontent.com/50383431/151224157-6de89278-4d38-4721-815c-742419bab2f1.png)

    </details>
  
  </details>

</details>
  
 
# Reinforcement Learning
<details>
<summary markdown="spawn"> Click to expand! </summary>
  Nothing yet but soon !
</details>

